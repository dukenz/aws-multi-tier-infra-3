terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Uncomment to use S3 remote backend (recommended for team use)
  # backend "s3" {
  #   bucket         = "your-terraform-state-bucket"
  #   key            = "aws-multi-tier-infra/terraform.tfstate"
  #   region         = "us-east-1"
  #   encrypt        = true
  #   dynamodb_table = "terraform-state-lock"
  # }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "aws-multi-tier-infra"
      ManagedBy   = "Terraform"
      Owner       = "Duke Nzekwe"
      Environment = var.environment
    }
  }
}
