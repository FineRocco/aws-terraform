output "ecr_repository_url" {
  description = "The ECR URL for the GitHub Actions pipeline"
  value       = module.dev_stack.ecr_repository_url
}

output "dev_db_endpoint" {
  description = "The RDS connection string"
  value       = module.dev_stack.db_endpoint
}

output "dev_web_public_ip" {
  description = "The public IP of the Dev web server"
  value       = module.dev_stack.web_public_ip
}

output "dev_ec2_instance_id" {
  description = "The ID of the Dev EC2 instance for SSM deployment"
  value       = module.dev_stack.ec2_instance_id
}

output "codedeploy_s3_bucket" {
  description = "The S3 bucket used for CodeDeploy artifacts"
  value       = module.dev_stack.codedeploy_s3_bucket
}