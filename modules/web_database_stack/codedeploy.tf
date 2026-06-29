
resource "aws_s3_bucket" "codedeploy_bucket" {
  bucket_prefix = "${var.environment}-codedeploy-artifacts-"
  force_destroy = true # Allows Terraform to easily destroy it later
}

resource "aws_codedeploy_app" "web_app" {
  name             = "${var.environment}-flask-app-deploy"
  compute_platform = "Server"
}

resource "aws_codedeploy_deployment_group" "web_deployment_group" {
  app_name              = aws_codedeploy_app.web_app.name
  deployment_group_name = "${var.environment}-deployment-group"
  service_role_arn      = aws_iam_role.codedeploy_service_role.arn

  ec2_tag_set {
    ec2_tag_filter {
      key   = "Name"
      type  = "KEY_AND_VALUE"
      value = "${var.environment}-web-server"
    }
  }
}