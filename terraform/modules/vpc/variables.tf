variable "project" {
  type        = string
  description = "Project identifier used for naming and tags"
}

variable "env" {
  type        = string
  description = "Environment identifier (e.g., dev, stage, prod)"
}

variable "aws_region" {
  type        = string
  description = "AWS region where the VPC will be created"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for public subnets"
  default     = [
    "10.0.0.0/20",
    "10.0.16.0/20"
  ]
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for private subnets"
  default     = [
    "10.0.32.0/20",
    "10.0.48.0/20"
  ]
}