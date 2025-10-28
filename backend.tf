terraform {
  required_version = ">= 1.2.0"

  backend "s3" {
    bucket         = "thesis-terraform-state-thesis-devops-edge"
    key            = "thesis-infra/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "thesis-terraform-locks"
  }
}
