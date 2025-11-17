variable "vpc_id" {}
variable "vpc_public_subnets" { type = list(string) }
variable "key_name" {}
variable "admin_ip" {}
variable "project" {
  type    = string
  default = "thesis-devops-jenkins"
}
variable "edge_instance_type" {
  type    = string
  default = "t3.micro"
  #default = "t3.small"
}

variable "ami_id" {
  description = "AMI base para jenkins"
  type        = string
}
variable "instance_type" {
  description = "Tipo de instancia EC2"
  type        = string
  default     = "t3.micro"
}
