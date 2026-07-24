terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}

module "ecr" {
  source                   = "../../modules/ecr"
  frontend_repository_name = "dev-jerney-frontend"
  backend_repository_name  = "dev-jerney-backend"
}

module "iam_github_oidc" {
  source = "../../modules/iam-github-oidc"

  role_name   = "github-actions-role"
  policy_name = "github-actions-ecr-policy"

  frontend_repository_arn = module.ecr.frontend_repository_arn
  backend_repository_arn  = module.ecr.backend_repository_arn
  github_repository       = "srjsilwal/3-tier-application-devopsify"
  github_branch           = "main"
}

module "networking" {
  source = "../../modules/networking"

  vpc_name              = "jerney-vpc"
  vpc_cidr              = "10.0.0.0/16"
  public_subnet_1_cidr  = "10.0.1.0/24"
  public_subnet_2_cidr  = "10.0.2.0/24"
  private_subnet_1_cidr = "10.0.11.0/24"
  private_subnet_2_cidr = "10.0.12.0/24"

  internet_gateway_name = "jerney_igw"
}

module "rds" {
  source             = "../../modules/rds"
  db_name            = "jerney"
  db_user            = "postgres"
  db_password        = var.db_password
  vpc_id             = module.networking.vpc_id
  private_subnet_ids = module.networking.private_subnet_ids
}

module "eks" {
  source             = "../../modules/eks"
  cluster_name       = "jerney-cluster"
  vpc_id             = module.networking.vpc_id
  public_subnet_ids  = module.networking.public_subnet_ids
  private_subnet_ids = module.networking.private_subnet_ids
}
