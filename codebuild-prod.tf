
# CodeBuild module for fanchiikawa-server
# Note: Module name contains "dev" but is configured for all environments via variables (Terraform limitation: module names must be static)
module "fanchiikawa-server-dev-codebuild" {
  source = "./modules/codebuild"
  code_source = "https://github.com/smartiful/fanchiikawa-server"
  # Pass data source output to module
  codebuild_github_personal_token = data.aws_secretsmanager_secret_version.codebuild_github_token.secret_string
  ecr_url = module.ecr_fanchiikawa_server.repository_url
  name = "fanchiikawa-server"
  namespace = var.namespace
  service_role_arn = data.aws_iam_role.codebuild.arn
  branch = var.git_branch
  notification_topic = module.codebuild_sns_topic.sns_topic_arn
  depends_on = [module.codebuild_sns_topic]
  environment = var.environment
  cluster_name = var.eks_cluster_name
}
