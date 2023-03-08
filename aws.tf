terraform {
  required_version = ">= 1.3.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws",
      version = "4.23.0"
    }
    mysql = {
      source = "petoju/mysql"
      version = "3.0.27"
    }
  }
}