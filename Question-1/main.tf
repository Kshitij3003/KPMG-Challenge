terraform {
  required_version = ">= 0.15"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4"
    }
  }
  backend "s3" {
    bucket = "terraform-statefile-s3-bucket"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}