output "app_ecr_repo_url" {
  value = aws_ecr_repository.app.repository_url
}
output "app_url" {
  description = "Public URL of the application via Ingress"
  value       = "http://${kubernetes_ingress_v1.app.status[0].load_balancer[0].ingress[0].hostname}/"
}