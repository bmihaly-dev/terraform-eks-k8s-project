
data "aws_caller_identity" "current" {}



resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com"
  ]

  thumbprint_list = [
   
    "6938fd4d98bab03faadb97b34396831e3780aea1"
  ]
}



resource "aws_iam_role" "github_oidc_ecr" {
  name = "terraform-eks-k8s-ecr-oidc-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "GitHubOIDCAssumeRole"
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.github.arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          }
          StringLike = {
            
            "token.actions.githubusercontent.com:sub" = "repo:bmihaly-dev/terraform-eks-k8s-project:*"
          }
        }
      }
    ]
  })
}



resource "aws_iam_role_policy_attachment" "github_oidc_ecr_policy" {
  role       = aws_iam_role.github_oidc_ecr.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}
