data "aws_secretsmanager_secret_version" "codebuild_github_token" {
  # Use full ARN to reference existing GitHub Token Secret
  secret_id = var.github_token_secret_arn
}

# ✅ Added - Reference existing IAM Role
data "aws_iam_role" "codebuild" {
  name = var.codebuild_role_name
}

# ✅ Added - Reference existing IAM Policy (optional, if needed later)
data "aws_iam_policy" "code_build_policy" {
  arn = "arn:aws:iam::${var.aws_account_id}:policy/${var.codebuild_policy_name}"
}
