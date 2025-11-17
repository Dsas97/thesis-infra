variable "project" { type = string }
variable "vpc_id" { type = string }
variable "public_subnets" { type = list(string) }
variable "private_subnets" { type = list(string) }
variable "eks_node_instance_type" { type = string }
variable "aws_region" {
  type    = string
  default = "us-east-1"
}
variable "key_name" { 
    type = string
    default = "" 
}

# Aquí se definen placeholders para cuando implementes los nodos Edge
variable "k3s_server_url" {
  description = "URL del servidor K3s central (nodo Edge master)"
  type        = string
  default     = ""
}

variable "k3s_token" {
  description = "Token de autenticación del clúster K3s"
  type        = string
  default     = ""
}

variable "cluster_name" {
  description = "Nombre deseado para el clúster de EKS."
  type        = string
}

variable "cluster_version" {
  description = "Versión de Kubernetes para el clúster de EKS."
  type        = string
}

variable "admin_ip" {
  description = "Mi IP pública con acceso al cluster"
  type        = string
}