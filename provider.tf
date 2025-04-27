provider "aws" {
  region = terraform.workspace == "prod" ? "eu-central-1" : "us-east-1"
  profile = "terraform-user"
}