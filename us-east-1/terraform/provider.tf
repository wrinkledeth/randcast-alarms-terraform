# Best practices for using Terraform 
# https://cloud.google.com/docs/terraform/best-practices-for-terraform
provider "aws" {
  region = var.region
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.27.0"
    }
  }

  required_version = "~> 1.0"
}
