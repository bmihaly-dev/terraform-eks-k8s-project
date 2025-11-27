resource "kubernetes_ingress_v1" "app" {
  metadata {
    name      = "${local.app_name}-ingress"
    namespace = kubernetes_namespace_v1.app.metadata[0].name

    annotations = {
      
      "kubernetes.io/ingress.class" = "nginx"
    }
  }

  spec {
    
    ingress_class_name = "nginx"

    rule {
      
      http {
        path {
          path      = "/"
          path_type = "Prefix"

          backend {
            service {
              name = kubernetes_service_v1.app.metadata[0].name

              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}
