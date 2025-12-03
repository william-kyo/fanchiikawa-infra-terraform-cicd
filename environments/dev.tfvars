# ===== Dev Environment Configuration =====
# AWS Account: 111122223333

# AWS basic configuration
aws_account_id = "111122223333"
aws_region     = "ap-northeast-1"

# Environment identification
environment = "dev"
namespace   = "fanchiikawa-dev"


# EKS configuration
eks_cluster_name = "fanchiikawa-eks-dev-c3gl47pn"

# IAM resource names
codebuild_role_name   = "code-build-role-fanchiikawa-dev"
codebuild_policy_name = "code-build-policy-fanchiikawa-dev"

# Secrets Manager
github_token_secret_arn = "arn:aws:secretsmanager:ap-northeast-1:111122223333:secret:fanchiikawa/cicd/codebuild_github_token"

# Git configuration
git_branch = "dev"

# Remote State configuration
remote_state_namespace = "fanchiikawa"
remote_state_stage     = "dev"

# Disable auto-generation of terraform.tf (manual maintenance + use backend-configs/*.hcl)
remote_state_terraform_backend_config_file_path = ""
