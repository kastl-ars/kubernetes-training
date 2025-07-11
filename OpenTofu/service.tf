resource "kubernetes_service" "nginx-opentofu" {
  metadata {
    name      = "nginx-opentofu"
    namespace = var.namespace
    labels = {
      app = "nginx"
    }
  }
  spec {
    type = "ClusterIP"
    selector = {
      app = "nginx-opentofu"
    }
    session_affinity = "None"
    port {
      port        = 80
      target_port = 8080
    }
  }
}
