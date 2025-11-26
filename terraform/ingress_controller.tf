resource "helm_release" "ingress_nginx" {
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = "ingress-nginx"

  create_namespace = true

  # Service type = LoadBalancer beállítás values-ban,
  # így nem kell set blokk, nem fogja aláhúzni semmi
  values = [
    yamlencode({
      controller = {
        service = {
          type = "LoadBalancer"
        }
      }
    })
  ]

  timeout       = 600
  wait          = true
  recreate_pods = false
}