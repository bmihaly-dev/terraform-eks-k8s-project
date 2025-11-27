resource "kubernetes_horizontal_pod_autoscaler_v2" "app" {
  metadata {
    name      = "${local.app_name}-hpa"
    namespace = kubernetes_namespace_v1.app.metadata[0].name
  }

  spec {
    scale_target_ref {
      api_version = "apps/v1"
      kind        = "Deployment"
      name        = kubernetes_deployment_v1.app.metadata[0].name
    }

    min_replicas = 2
    max_replicas = 5

    # CPU alapú autoscaling
    metric {
      type = "Resource"

      resource {
        name = "cpu"

        target {
          type               = "Utilization"
          average_utilization = 50
        }
      }
    }
  }
}