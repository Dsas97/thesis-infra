variable "ami_id" {
  description = "AMI base para el servidor K3s"
  type        = string
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  type        = string
  default     = "t3.micro"
}

variable "vpc_id" {
  description = "ID de la VPC donde se despliega el master"
  type        = string
}

variable "vpc_public_subnets" {
  description = "Subred pública para desplegar el master"
  type        = list(string)
}

variable "key_name" {
  description = "Nombre del par de claves SSH"
  type        = string
}

variable "ssh_private_key_path" {
  description = "Ruta al archivo de clave privada para conexión SSH"
  type        = string
}

variable "admin_ip" {
  description = "IP del administrador para acceso SSH (ejemplo: 181.x.x.x/32)"
  type        = string
}

variable "project" {
  description = "Nombre del proyecto"
  type        = string
}
