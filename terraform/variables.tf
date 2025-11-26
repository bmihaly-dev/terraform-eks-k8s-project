variable "aws_region" {
  description = "AWS region where we are creating VPC"
  type        = string
  default     = "eu-central-1"
}

variable "project" {
  description = "Projekt name"
  type        = string
  default     = "eks-k8s"
}

variable "env" {
  description = "Specifies the deployment environment (development, staging, production)"
  type        = string
  default     = "dev"
}