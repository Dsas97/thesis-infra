# thesis-infra

Infraestructura como código para el proyecto *thesis-devops-edge*.
Incluye Terraform modular, plantillas Packer y scripts de bootstrap.

## Estructura
- terraform/: Terraform root + modules
- packer/: Packer template y scripts
- scripts/: utilidades (crear backend S3 + DynamoDB)

## Requisitos
- AWS account con permisos (VPC, EC2, EKS, IAM, ECR, S3, DynamoDB)
- AWS CLI configurado
- Terraform >= 1.2.x
- Packer >= 1.8.x
- jq, unzip (opcionales)

## Uso rápido
1. Edita `backend.tf` con tu bucket S3 único.
2. Ejecuta `scripts/create-backend.sh` para crear bucket S3 y tabla DynamoDB (requiere AWS CLI).
3. `cd terraform && terraform init && terraform apply`

No guardes secretos en el repo. Usa AWS Secrets Manager o HashiCorp Vault.
# thesis-infra
