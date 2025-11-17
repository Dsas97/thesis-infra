#!/usr/bin/env bash
set -euo pipefail

# Las variables quedan igual
AWS_REGION="us-east-1"
BUCKET="thesis-terraform-state-david-edge-1"
DYNAMO_TABLE="thesis-terraform-locks"

echo "Creando bucket S3 '$BUCKET' en region $AWS_REGION (si no existe)..."

# --- INICIO DE LA CORRECCIÓN CLAVE ---
# El parámetro LocationConstraint debe omitirse para la región 'us-east-1'
# y usarse para todas las demás regiones.

if [ "$AWS_REGION" == "us-east-1" ]; then
    echo "Región detectada: us-east-1. Omitiendo LocationConstraint."
    # Comando corregido para us-east-1 (sin --create-bucket-configuration)
    aws s3api create-bucket --bucket "$BUCKET" --region "$AWS_REGION" || true
else
    echo "Región detectada: $AWS_REGION. Usando LocationConstraint."
    # Comando estándar para cualquier otra región (con --create-bucket-configuration)
    aws s3api create-bucket --bucket "$BUCKET" --region "$AWS_REGION" --create-bucket-configuration LocationConstraint="$AWS_REGION" || true
fi
# --- FIN DE LA CORRECCIÓN CLAVE ---

echo "Habilitando versioning y cifrado..."
# NOTA: Agregué '|| true' para manejar el caso de 'NoSuchBucket'
# si el bucket no se creó por un error no relacionado con la LocationConstraint.
aws s3api put-bucket-versioning --bucket "$BUCKET" --versioning-configuration Status=Enabled || true
aws s3api put-bucket-encryption --bucket "$BUCKET" --server-side-encryption-configuration '{"Rules":[{"ApplyServerSideEncryptionByDefault":{"SSEAlgorithm":"AES256"}}]}' || true

echo "Creando tabla DynamoDB '$DYNAMO_TABLE' para locking (si no existe)..."
# El comando de DynamoDB no tenía problemas
aws dynamodb describe-table --table-name "$DYNAMO_TABLE" --region "$AWS_REGION" >/dev/null 2>&1 || aws dynamodb create-table \
    --table-name "$DYNAMO_TABLE" \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
    --region "$AWS_REGION"

echo "Backend creado (o ya existente): bucket=$BUCKET, dynamodb=$DYNAMO_TABLE"