module "codebuild_sns_topic" {
  source  = "terraform-aws-modules/sns/aws"
  version = "~> 3.0"

  name  = "code-build-topic-fanchiikawa-env-${var.environment}"
}