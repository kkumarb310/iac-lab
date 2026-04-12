terraform {
  required_version = ">= 1.7.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

locals {
  workspace_tags = merge(var.common_tags, {
    env = terraform.workspace
  })
}

resource "random_id" "suffix" {
  byte_length = 4
}

module "s3_state" {
  source  = "./modules/s3"
  project = var.project
  suffix  = random_id.suffix.hex
  tags    = local.workspace_tags

  lifecycle_rules = {
    expire-old-versions = {
      enabled                    = true
      expiration_days            = 90
      noncurrent_expiration_days = 30
    }
    cleanup-incomplete-uploads = {
      enabled                    = true
      expiration_days            = 7
      noncurrent_expiration_days = 3
    }
  }
}

resource "aws_dynamodb_table" "terraform_lock" {
  name         = "${var.project}-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = local.workspace_tags
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}