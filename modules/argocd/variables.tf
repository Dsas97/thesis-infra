variable "cluster_name" {
  description = "Nombre del cluster EKS donde se desplegará ArgoCD"
}


variable "cluster_endpoint" {
  description = "CLuster endpoint Eks"
}

# Archivo kubeconfig para conectar desde CI/CD (nueva versión)
variable "cluster_certificate_authority_data" {
  description = "Certificado del cluster EKS (CA data)"
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}
