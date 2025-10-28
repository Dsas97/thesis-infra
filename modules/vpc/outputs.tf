output "vpc_id" { value = module.vpc_default.vpc_id }
output "public_subnets" { value = module.vpc_default.public_subnets }
output "private_subnets" { value = module.vpc_default.private_subnets }
