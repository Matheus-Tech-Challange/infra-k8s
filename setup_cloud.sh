#!/bin/bash

# Defina a região
REGION="us-east-1"

# Defina os nomes dos buckets (devem ser únicos globalmente)
BUCKET_NAME_1="pediaqui-infra-cloud-bucket"
BUCKET_NAME_2="pediaqui-infra-database-bucket"
BUCKET_NAME_3="pediaqui-catalog-bucket"
BUCKET_NAME_4="pediaqui-payment-bucket"
BUCKET_NAME_5="pediaqui-order-bucket"

# Defina os nomes dos repositórios ECR
ECR_REPOSITORY_NAME_1="pediaqui-catalog-image"
ECR_REPOSITORY_NAME_2="pediaqui-order-image"
ECR_REPOSITORY_NAME_3="pediaqui-payment-image"

# Função para criar um bucket S3
create_bucket() {
    BUCKET_NAME=$1
    echo "Criando bucket: $BUCKET_NAME na região $REGION..."
    
    # Comando AWS CLI para criar o bucket
    aws s3api create-bucket --bucket "$BUCKET_NAME" --region "$REGION" --no-cli-pager
    
    if [ $? -eq 0 ]; then
        echo "Bucket $BUCKET_NAME criado com sucesso!"
    else
        echo "Falha ao criar o bucket $BUCKET_NAME."
    fi
}

# Função para criar um repositório ECR
create_ecr_repository() {
    REPOSITORY_NAME=$1
    echo "Criando repositório ECR: $REPOSITORY_NAME na região $REGION..."
    
    # Comando AWS CLI para criar o repositório ECR
    aws ecr create-repository --repository-name "$REPOSITORY_NAME" --region "$REGION" --no-cli-pager
    
    if [ $? -eq 0 ]; then
        echo "Repositório ECR $REPOSITORY_NAME criado com sucesso!"
    else
        echo "Falha ao criar o repositório ECR $REPOSITORY_NAME."
    fi
}

# Criar os 5 buckets
create_bucket "$BUCKET_NAME_1"
create_bucket "$BUCKET_NAME_2"
create_bucket "$BUCKET_NAME_3"
create_bucket "$BUCKET_NAME_4"
create_bucket "$BUCKET_NAME_5"

# Criar os 5 repositórios ECR
create_ecr_repository "$ECR_REPOSITORY_NAME_1"
create_ecr_repository "$ECR_REPOSITORY_NAME_2"
create_ecr_repository "$ECR_REPOSITORY_NAME_3"

echo "Script finalizado."
