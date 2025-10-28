variable "project" { type = string }
variable "aws_region" { 
    type = string 
    default = "us-east-1" 
}
variable "vpc_cidr" { type = string }
variable "public_subnets" { type = list(string) }
variable "private_subnets" { type = list(string) }
