resource "kubernetes_ingress" "hello" {
  wait_for_load_balancer = true
  metadata {
    name = "nginx-hello"
    namespace = kubernetes_namespace.development.metadata.0.name
  }
  spec {
    ingress_class_name = "nginx"
    rule {
      host = "hello.jb-host.net"
      http {
        path {
          path = "/"
          backend {
            service_name = "nginx-hello"
            service_port = 8080
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "hello" {
  metadata {
    name      = "nginx-hello"
    namespace = kubernetes_namespace.development.metadata.0.name
  }
  spec {
    selector = {
      app = "nginx-hello"
    }
    type = "NodePort"
    port {
      port        = 8080
      target_port = 80
    }
  }
}

resource "kubernetes_deployment" "hello" {
  metadata {
    name = "nginx-hello"
    namespace = kubernetes_namespace.development.metadata.0.name
    labels = {
      app = "nginx-hello"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "nginx-hello"
      }
    }

    template {
      metadata {
        labels = {
          app = "nginx-hello"
        }
      }

      spec {
        container {
          name  = "nginx-hello"
          image = "nginxdemos/hello:latest"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}
