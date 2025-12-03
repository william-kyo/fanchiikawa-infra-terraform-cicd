variable "remote_state_namespace" {
  type        = string
  default     = "fanchiikawa"
  description = "Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp'"
}


variable "remote_state_stage" {
  type        = string
  default     = "dev"
  description = "Stage, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release'"
}

variable "remote_state_profile" {
  type        = string
  default     = ""
  description = "AWS profile name as set in the shared credentials file"
}

variable "remote_state_terraform_backend_config_file_name" {
  type        = string
  default     = "terraform.tf"
  description = "Name of terraform backend config file"
}

variable "remote_state_terraform_backend_config_file_path" {
  type        = string
  default     = "."
  description = "Directory for the terraform backend config file, usually `.`. The default is to create no file."
}

# ===== Environment-related variables =====

variable "aws_account_id" {
  type        = string
  description = "AWS Account ID for the target environment"
}

variable "aws_region" {
  type        = string
  default     = "ap-northeast-1"
  description = "AWS region for resources"
}

variable "environment" {
  type        = string
  description = "Environment name (dev, staging, prod)"
}

variable "namespace" {
  type        = string
  description = "Namespace for resource naming (e.g., fanchiikawa-dev, fanchiikawa-prod)"
}

variable "eks_cluster_name" {
  type        = string
  description = "EKS cluster name for the environment"
}

variable "codebuild_role_name" {
  type        = string
  description = "IAM role name for CodeBuild"
}

variable "codebuild_policy_name" {
  type        = string
  description = "IAM policy name for CodeBuild"
}

variable "github_token_secret_arn" {
  type        = string
  description = "ARN of the GitHub token secret in Secrets Manager"
}

variable "git_branch" {
  type        = string
  description = "Git branch to trigger CodeBuild (e.g., dev, release, main)"
}

