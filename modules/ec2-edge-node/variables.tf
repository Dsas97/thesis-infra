variable "edge_count" { type = number }
variable "ami_id" { type = string }
variable "edge_instance_type" { type = string }
variable "vpc_public_subnets" { type = list(string) }
variable "key_name" { type = string }
variable "project" { type = string }
variable "k3s_url" {
  description = "URL del servidor K3s al que se unirá el nodo edge"
  type        = string
}

variable "k3s_token" {
  description = "Token de autenticación del servidor K3s"
  type        = string
}
