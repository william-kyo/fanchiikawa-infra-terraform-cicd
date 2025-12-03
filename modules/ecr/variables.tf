variable "name" {
  type        = string
  description = "Name of ECR"
}

variable "mutability" {
  type        = string
  description = "Mutability of ECR"
  default     = "MUTABLE"
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}