output "s3_bucket_id" {
  value       = module.terraform_state_backend.s3_bucket_id
  description = "S3 bucket ID"
}

output "s3_bucket_arn" {
  value       = module.terraform_state_backend.s3_bucket_arn
  description = "S3 bucket ARN"
}

output "dynamodb_table_id" {
  value       = module.terraform_state_backend.dynamodb_table_id
  description = "DynamoDB table ID"
}

output "dynamodb_table_arn" {
  value       = module.terraform_state_backend.dynamodb_table_arn
  description = "DynamoDB table ARN"
}