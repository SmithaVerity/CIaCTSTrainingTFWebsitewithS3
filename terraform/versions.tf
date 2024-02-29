provider "aws" {
  region = var.region
  access_key =""
  secret_key =""

  default_tags {
    tags = {
      Owner       = "Todd"
      Provisioner = "Terraform"
    }
  }
}

terraform {
  required_version = ">= 1.5.4"
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}
