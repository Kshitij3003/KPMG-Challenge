terraform {
  required_version = ">= 0.15"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4"
    }
  }
  backend "s3" {
    bucket = "terraform-statelist"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}