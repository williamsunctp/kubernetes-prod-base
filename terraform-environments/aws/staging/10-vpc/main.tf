locals {
  aws_region       = "us-east-1"
  environment_name = "staging"
  tags = {
    ops_env              = "${local.environment_name}"
    ops_managed_by       = "terraform",
    ops_source_repo      = "kubernetes-ops",
    ops_source_repo_path = "terraform-environments/aws/${local.environment_name}/10-vpc",
    ops_owners           = "devops",
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.37.0"
    }
  }

  backend "remote" {
    # Update to your Terraform Cloud organization
    organization = "managedkube"

    workspaces {
      name = "kubernetes-ops-staging-10-vpc"
    }
  }
}

provider "aws" {
  region = local.aws_region
}

#
# VPC
#
module "vpc" {
  source = "github.com/ManagedKube/kubernetes-ops//terraform-modules/aws/vpc?ref=v1.0.30"

  aws_region       = local.aws_region
  azs              = ["us-east-1a", "us-east-1c", "us-east-1d"]
  vpc_cidr         = "10.0.0.0/16"
  private_subnets  = ["10.0.0.0/19", "10.0.32.0/19", "10.0.64.0/19"]
  public_subnets   = ["10.0.128.0/20", "10.0.144.0/20", "10.0.160.0/20"]
  environment_name = local.environment_name
  cluster_name     = local.environment_name
  tags             = local.tags
}
