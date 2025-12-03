# You cannot create a new backend by simply defining this and then
# immediately proceeding to "terraform apply". The S3 backend must
# be bootstrapped according to the simple yet essential procedure in
# https://github.com/cloudposse/terraform-aws-tfstate-backend#usage
module "terraform_state_backend" {
  source                             = "git::https://github.com/cloudposse/terraform-aws-tfstate-backend.git?ref=v1.7.1"
  namespace                          = var.remote_state_namespace
  stage                              = var.remote_state_stage
  name                               = "cicd"
  profile                            = var.remote_state_profile
  attributes                         = ["state"]
  terraform_backend_config_file_path = var.remote_state_terraform_backend_config_file_path
  #terraform_backend_config_file_path = ""
  terraform_backend_config_file_name = var.remote_state_terraform_backend_config_file_name
  force_destroy                      = false
}
