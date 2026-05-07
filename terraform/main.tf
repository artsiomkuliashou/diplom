terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }  

  # S3 backend (раскомментировать после создания бакета через storage.tf)
   backend "s3" {
     bucket         = "habit-tracker-tfstate-654654486478"
     key            = "terraform.tfstate"
     region         = "eu-central-1"
     dynamodb_table = "habit-tracker-tflock"
     encrypt        = true
   }
}

provider "aws" {
  region = var.aws_region
}
