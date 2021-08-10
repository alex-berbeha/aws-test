terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "s3" {
    bucket = "aws-test-task-terraform-state-berbeha"
    key    = "terraform-backend"
    region = "us-west-1"
  }
}

provider "aws" {
  region = var.region
}