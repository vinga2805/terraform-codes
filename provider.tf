provider "aws" {
  region = var.region
}
terraform {
  backend "s3" {
    bucket = "vinga-demo-terraform-state"
    key    = "terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "terraform-lock"
  }
}
