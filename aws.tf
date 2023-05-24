terraform {
  required_version = ">= 1.3.3"
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    mysql = {
      source  = "petoju/mysql"
      version = "3.0.36"
    }
  }
}

provider "aws" {
  profile = "ttn-ott-demo"
}