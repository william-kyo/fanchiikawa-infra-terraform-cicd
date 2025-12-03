# Backend configuration for Dev environment
# Usage: terraform init -backend-config=backend-configs/dev.hcl

bucket         = "fanchiikawa-dev-cicd-state"
key            = "terraform.tfstate"
region         = "ap-northeast-1"
dynamodb_table = "fanchiikawa-dev-cicd-state-lock"
encrypt        = true
profile        = ""
