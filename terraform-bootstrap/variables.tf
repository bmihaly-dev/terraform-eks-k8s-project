variable "aws_region" {
  type        = string
  default     = "eu-central-1"
  description = "AWS region to create the remote state resources in."
}

variable "project" {
  type        = string
  default     = "terraform-eks-k8s-project"
  description = "Base project name used for tagging and naming."
}

variable "env" {
  type        = string
  default     = "dev"
  description = "Environment name (dev/stage/prod)."
}