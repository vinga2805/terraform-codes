provider "aws" {
  region = var.region
}
terraform {
  backend "s3" {
    bucket = "vinga-terraform-state"
    key    = "demo/stage/terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "terraform-lock"
  }
}
