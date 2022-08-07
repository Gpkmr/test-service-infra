data "google_client_config" "client" {}

provider "kubernetes" {
  #load_config_file = false
  host = "https://${var.gke_endpoint}"
  cluster_ca_certificate = base64decode(var.gke_cert)
  token = data.google_client_config.client.access_token
}

resource "kubernetes_deployment" "app_deploy" {
  metadata {
    name = var.deploy_name
    labels = {
      app = var.label
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = var.label
      }
    }

    template {
      metadata {
        labels = {
          app = var.label
        }
      }

      spec {
        container {
          image = var.image
          name  = var.image_name

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "app_service" {
  metadata {
    name = var.svc_name
    annotations = {
      "networking.gke.io/load-balancer-type" = "Internal"
    }
  }
  spec {
    selector = {
      app = kubernetes_deployment.app_deploy.metadata.0.labels.app
    }
    port {
      port        = var.svc_port
      target_port = var.container_port
    }

    type = "LoadBalancer"
  }
}