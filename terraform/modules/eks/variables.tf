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
  description = "AWS region where the EKS cluster will be created"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC where the EKS cluster and nodes will run"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "Private subnet IDs for worker nodes"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "Public subnet IDs (can be used by the control plane if needed)"
}

variable "cluster_version" {
  type        = string
  description = "Kubernetes version for the EKS cluster"
  default     = "1.30"
}

variable "node_group_min_size" {
  type        = number
  description = "Minimum number of nodes in the managed node group"
  default     = 1
}

variable "node_group_max_size" {
  type        = number
  description = "Maximum number of nodes in the managed node group"
  default     = 3
}

variable "node_group_desired_size" {
  type        = number
  description = "Desired number of nodes in the managed node group"
  default     = 1
}

variable "node_instance_type" {
  type        = string
  description = "EC2 instance type for worker nodes"
  default     = "t3.small"
}