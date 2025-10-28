module "vpc_default" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.18.0"

  name = "${var.project}-vpc"
  cidr = var.vpc_cidr

  azs = ["${var.aws_region}a","${var.aws_region}b"]
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Project = var.project
  }
}

output "vpc_id" {
  value = module.vpc_default.vpc_id
}
output "public_subnets" {
  value = module.vpc_default.public_subnets
}
output "private_subnets" {
  value = module.vpc_default.private_subnets
}
