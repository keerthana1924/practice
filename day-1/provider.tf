

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.76.0"  # Use any version = 5.76.0
    }
  }
}


provider "aws" {
    region = "us-west-2"
  
}