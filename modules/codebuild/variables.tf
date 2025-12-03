variable "name" {
  type = string
  description = "name of the project, must be same with folder"
}

variable "trigger_by_root_path" {
  type = bool
  description = "trigger the pipeline by any change"
  default = false
}

variable "branch" {
  type = string
  description = "The branch that trigger this build"
}

variable "deploy_type" {
  type = string
  description = "how this project is deployed, k8s deployment or statefulset  or daemonSet "
  default = "deployment"
}

variable "namespace" {
  type = string
  description = "which namespace in k8s does this deploy"
  default = "umi-testnet"
}

variable "ecr_url" {
  type = string
  description = "ecr url to push images"

}

variable "code_source" {
  type = string
  description = "source code repo"
}

variable "codebuild_github_personal_token" {
  type = string
  description = "github personal token"
  sensitive   = true
}

variable "service_role_arn" {
  type = string
  description = "service role for this build"
}

variable "notification_topic" {
  type = string
  description = "sns topic to inform deploy status"
}

variable "concurrent_build_limit" {
  type = number
  description = "concurrent level for code build"
  default = 1
}

variable "environment" {
  type = string
  description = "The environment of the project"
}

variable "cluster_name" {
  type = string
  description = "The EKS cluster name"
}
