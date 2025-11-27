resource "kubernetes_service_v1" "app" {
  metadata {
    name      = "${local.app_name}-svc"
    namespace = kubernetes_namespace_v1.app.metadata[0].name

    labels = {
      app     = local.app_name
      project = var.project
      env     = var.env
    }
  }

  spec {
    selector = {
      app = local.app_name
    }

    port {
      port        = 80      
      target_port = 80   
      protocol    = "TCP"
    }

    type = "ClusterIP"      
  }
}