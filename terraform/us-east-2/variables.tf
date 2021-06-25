variable "name_prefix" {
  type = string
  default = "app"
  description = "Prefix to be used on each infrastructure object Name created in AWS."
}

variable "region" {
  type = string
  default = "us-east-2"
}

variable "environment" {
  type = string
  default = "dev"
}

variable "admin_users" {
  type = list(string)
  default = ["john"]
  description = "List of Kubernetes admins."
}

variable "developer_users" {
  type = list(string)
  default = ["nagy"]
  description = "List of Kubernetes developers."
}

variable "main_network_block" {
  type = string
  default = "10.0.0.0/16"
  description = "Base CIDR block to be used in our VPC."
}

variable "subnet_prefix_extension" {
  type = number
  default = 4
  description = "CIDR block bits extension to calculate CIDR blocks of each subnetwork."
}

variable "zone_offset" {
  type = number
  default = 8
  description = "CIDR block bits extension offset to calculate Public subnets, avoiding collisions with Private subnets."
}

variable "asg_instance_types" {
  type = list(string)
  default = ["t3.small", "t2.small"]
  description = "List of EC2 instance machine types to be used in EKS."
}

variable "autoscaling_minimum_size_by_az" {
  type = number
  default = 1
  description = "Minimum number of EC2 instances to autoscale our EKS cluster on each AZ."
}

variable "autoscaling_maximum_size_by_az" {
  type = number
  default = 3
  description = "Maximum number of EC2 instances to autoscale our EKS cluster on each AZ."
}

variable "autoscaling_average_cpu" {
  type = number
  default = 30
  description = "Average CPU threshold to autoscale EKS EC2 instances."
}
