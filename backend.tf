terraform {
  required_version = ">= 1.2.0"

  backend "s3" {
    bucket         = "thesis-terraform-state-david-edge-2025"
    key            = "thesis-infra/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "thesis-terraform-locks"
  }
}
