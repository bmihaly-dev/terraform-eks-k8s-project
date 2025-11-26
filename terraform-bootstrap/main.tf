data "aws_caller_identity" "current" {}

locals {
  name_prefix = "${var.project}-${var.env}"
  account_id  = data.aws_caller_identity.current.account_id
}


resource "aws_s3_bucket" "tf_state" {
  bucket = "tf-state-eks-${local.account_id}-${var.aws_region}"
  force_destroy = true

  tags = {
    Name    = "${local.name_prefix}-tf-state"
    project = var.project
    env     = var.env
  }
}


resource "aws_s3_bucket_versioning" "tf_state_versioning" {
  bucket = aws_s3_bucket.tf_state.id

  versioning_configuration {
    status = "Enabled"
  }
}


resource "aws_s3_bucket_public_access_block" "tf_state_public_access" {
  bucket = aws_s3_bucket.tf_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


resource "aws_s3_bucket_server_side_encryption_configuration" "tf_state_encryption" {
  bucket = aws_s3_bucket.tf_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}


resource "aws_dynamodb_table" "tf_lock" {
  name         = "tf-lock-eks-${var.env}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name    = "${local.name_prefix}-tf-lock"
    project = var.project
    env     = var.env
  }
}
