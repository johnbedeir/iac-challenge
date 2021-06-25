terraform {
  required_version = ">= 0.13.1"

  required_providers {
    aws        = "~> 3.38"
    kubernetes = "~> 2.1"
    helm = "~> 2.1"
    google = "~> 3.39.0"
  }
}
