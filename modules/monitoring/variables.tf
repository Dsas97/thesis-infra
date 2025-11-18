variable "cluster_name" {
  description = "Nombre del cluster EKS donde se desplegará Prometheus/Grafana"
  type        = string
}

variable "grafana_admin_password" {
  description = "Contraseña del usuario admin de Grafana"
  type        = string
  sensitive   = true
}

variable "cluster_endpoint" {
  description = "Endpoint del cluster EKS"
  type        = string
}

variable "cluster_certificate_authority_data" {
  description = "Certificado del cluster EKS (CA data)"
  type        = string
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "project" { type = string }