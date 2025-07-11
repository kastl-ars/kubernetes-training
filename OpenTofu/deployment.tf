resource "kubernetes_deployment" "nginx-opentofu" {
  metadata {
    name      = "nginx-opentofu"
    namespace = var.namespace
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "nginx-opentofu"
      }
    }
    template {
      metadata {
        labels = {
          app = "nginx-opentofu"
        }
      }
      spec {
        container {
          image = "quay.io/packit/nginx-unprivileged"
          name  = "nginx-container"
          port {
            container_port = 8080
          }
        }
      }
    }
  }
}
