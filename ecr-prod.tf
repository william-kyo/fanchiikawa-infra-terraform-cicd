module "ecr_fanchiikawa_server" {
  source = "./modules/ecr"
  tags = {
    Environment    = "env-${var.environment}"
    terraform_repo = "terraform-cicd"
    service_type   = "grpc"
  }
  name = "fanchiikawa-server"
}
