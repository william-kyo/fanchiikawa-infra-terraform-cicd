terraform {
  required_version = ">= 1.0.0"

  # Partial backend configuration
  # Complete configuration provided via -backend-config flag
  # Usage: terraform init -backend-config=backend-configs/<env>.hcl
  backend "s3" {
    # All values provided by backend config files
    # See backend-configs/ directory
  }
}
