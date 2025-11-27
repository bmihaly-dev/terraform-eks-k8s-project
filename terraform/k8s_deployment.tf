
variable "app_image_tag" {
  type    = string
  default = "latest"
}



locals {
  app_name      = "${var.project}-${var.env}-app"
  app_namespace = kubernetes_namespace_v1.app.metadata[0].name
}

resource "kubernetes_deployment_v1" "app" {
  metadata {
    name      = local.app_name
    namespace = local.app_namespace

    labels = {
      app     = local.app_name
      project = var.project
      env     = var.env
    }
  }

  spec {
    
    replicas = 2

   
    selector {
      match_labels = {
        app = local.app_name
      }
    }

    template {
      metadata {
        labels = {
          app     = local.app_name
          project = var.project
          env     = var.env
        }
      }

      spec {
        container {
          name  = "app-container"

         
          image = "${aws_ecr_repository.app.repository_url}:${var.app_image_tag}"

         
          port {
            container_port = 3000
          }

         
          resources {
            requests = {
              cpu    = "100m"
              memory = "128Mi"
            }

            limits = {
              cpu    = "500m"
              memory = "256Mi"
            }
          }
        }
      }
    }
  }
}
