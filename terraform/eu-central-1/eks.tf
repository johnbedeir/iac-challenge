data "aws_availability_zones" "available" {}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

data "aws_caller_identity" "current" {} # used for accesing Account ID and ARN


# render Admin & Developer users list with the structure required by EKS module
locals {
  cluster_name = "app-${var.environment}"

  admin_user_map_users = [
    for admin_user in var.admin_users :
    {
      userarn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${admin_user}"
      username = admin_user
      groups   = ["system:masters"]
    }
  ]

  developer_user_map_users = [
    for developer_user in var.developer_users :
    {
      userarn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${developer_user}"
      username = developer_user
      groups   = ["${var.name_prefix}-developers"]
    }
  ]

  worker_groups_launch_template = [
    {
      override_instance_types = var.asg_instance_types
      asg_desired_capacity    = var.autoscaling_minimum_size_by_az * length(data.aws_availability_zones.available.zone_ids)
      asg_min_size            = var.autoscaling_minimum_size_by_az * length(data.aws_availability_zones.available.zone_ids)
      asg_max_size            = var.autoscaling_maximum_size_by_az * length(data.aws_availability_zones.available.zone_ids)
      kubelet_extra_args      = "--node-labels=node.kubernetes.io/lifecycle=spot" # use Spot EC2 instances to save some money and scale more
      public_ip               = true
    },
  ]
}


# reserve Elastic IP to be used in our NAT gateway
resource "aws_eip" "nat_gw_elastic_ip" {
  vpc = true

  tags = {
    Name            = "${local.cluster_name}-nat-eip"
    Terraform = "true"
    Environment = "dev"
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 15.1.0"

  cluster_name    = local.cluster_name
  cluster_version = "1.19"
  write_kubeconfig = false

  subnets = module.vpc.private_subnets
  vpc_id = module.vpc.vpc_id

  worker_groups_launch_template = local.worker_groups_launch_template

  # map developer & admin ARNs as kubernetes Users
  map_users = concat(local.admin_user_map_users, local.developer_user_map_users)

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}
