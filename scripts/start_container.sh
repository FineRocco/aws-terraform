#!/bin/bash
REGION="eu-west-1"
source /home/ec2-user/flask-deployment/.env

echo "Authenticating with ECR..."
aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $ECR_URL

echo "Pulling latest image..."
docker pull $ECR_URL

echo "Securely fetching Zero-Knowledge credentials..."
RAW_SECRET=$(aws secretsmanager get-secret-value --secret-id dev-postgres-credentials --query SecretString --output text --region $REGION)
PARSED_PASS=$(echo $RAW_SECRET | jq -r .password)

echo "Starting new container..."
docker run -d --name flask-app -p 80:80 \
  -e DB_HOST=$DB_HOST \
  -e DB_USER=dbadmin \
  -e DB_NAME=postgres \
  -e DB_PASS="$PARSED_PASS" \
  $ECR_URL

echo "Waiting for container initialization..."
sleep 15

echo "Seeding database..."
docker exec flask-app python /app/seed_db.py