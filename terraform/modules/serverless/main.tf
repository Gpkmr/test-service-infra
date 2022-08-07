resource "google_cloud_run_service" "srvone" {
  name     = "service-one-dev"
  location = "us-central1"
  template {
    spec {
      containers {
        image = "us-east1-docker.pkg.dev/autodidact/registry-dev/srvone:latest"
        env {
          name  = "SERVICE_TWO_URL"
          value = "http://10.3.0.11:80/two"
        }
      }
    }
  }
  traffic {
    percent         = 100
    latest_revision = true
  }
  metadata {
    annotations = {
      "run.googleapis.com/vpc-access-connector" = var.vpc_conn_id
      "run.googleapis.com/vpc-access-egress"    = "all-traffic"
    }
  }

  lifecycle {
    ignore_changes = [
        metadata.0.annotations,
    ]
  }
}