#!/usr/bin/env bash
set -euo pipefail

AWS_REGION="us-east-1"
BUCKET="thesis-terraform-state-thesis-devops-edge"
DYNAMO_TABLE="thesis-terraform-locks"

echo "Creando bucket S3 '$BUCKET' en region $AWS_REGION (si no existe)..."
aws s3api create-bucket --bucket "$BUCKET" --region "$AWS_REGION" --create-bucket-configuration LocationConstraint="$AWS_REGION" || true

echo "Habilitando versioning y cifrado..."
aws s3api put-bucket-versioning --bucket "$BUCKET" --versioning-configuration Status=Enabled
aws s3api put-bucket-encryption --bucket "$BUCKET" --server-side-encryption-configuration '{"Rules":[{"ApplyServerSideEncryptionByDefault":{"SSEAlgorithm":"AES256"}}]}'

echo "Creando tabla DynamoDB '$DYNAMO_TABLE' para locking (si no existe)..."
aws dynamodb describe-table --table-name "$DYNAMO_TABLE" --region "$AWS_REGION" >/dev/null 2>&1 || aws dynamodb create-table   --table-name "$DYNAMO_TABLE"   --attribute-definitions AttributeName=LockID,AttributeType=S   --key-schema AttributeName=LockID,KeyType=HASH   --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5   --region "$AWS_REGION"

echo "Backend creado (o ya existente): bucket=$BUCKET, dynamodb=$DYNAMO_TABLE"
