resource "kubernetes_ingress_v1" "nginx-opentofu" {
  metadata {
    name      = "nginx-opentofu"
    namespace = var.namespace
    annotations = {
      "route.openshift.io/termination" = "edge"
    }
  }
  spec {
    rule {
      host = var.ingress_hostname
      http {
        path {
          backend {
            service {
              name = "nginx-opentofu"
              port {
                number = 80
              }
            }
          }
          path = "/"
        }
      }
    }
  }
}
