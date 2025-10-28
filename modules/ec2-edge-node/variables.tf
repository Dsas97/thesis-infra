variable "edge_count" { type = number }
variable "ami_id" { type = string }
variable "edge_instance_type" { type = string }
variable "vpc_public_subnets" { type = list(string) }
variable "key_name" { type = string }
variable "project" { type = string }
