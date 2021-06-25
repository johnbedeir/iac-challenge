provider "aws" {
  region                  = var.region
  # shared_credentials_file = "$HOME/.aws/credentials"
  profile = "laravel-app"
  access_key = "AKIA2HE2YEL7CPIOYM4T"
  secret_key = "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"
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}
