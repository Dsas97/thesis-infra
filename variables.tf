variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "project" {
  type    = string
  default = "thesis-devops-edge"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  type    = list(string)
  default = ["10.0.1.0/24","10.0.2.0/24"]
}

variable "private_subnets" {
  type    = list(string)
  default = ["10.0.101.0/24","10.0.102.0/24"]
}

variable "edge_instance_type" {
  type    = string
  default = "t3.micro"
  #default = "t3.small"
}

variable "edge_count" {
  type    = number
  default = 3
}

variable "eks_node_instance_type" {
  type    = string
  default = "t3.micro"
  #default = "t3.medium"
}

variable "edge_ami_id" {
  type    = string
  default = "ami-0169cce1b30bd64b9"
}

variable "key_name" {
  type    = string
  default = "Tfm"
}

variable "ssh_private_key_path" {
  description = "Ruta al archivo de clave privada para conexión SSH"
  type        = string
}

variable "admin_ip" {
  description = "IP del administrador para acceso SSH (ejemplo: 181.x.x.x/32)"
  type        = string
}