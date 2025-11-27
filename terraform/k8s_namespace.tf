resource "kubernetes_namespace_v1" "app" {
  metadata {
    name = "${var.project}-${var.env}-app"

    labels = {
      project = var.project
      env     = var.env
      app     = "app"
    }
  }
}