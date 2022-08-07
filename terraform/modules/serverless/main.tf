resource "google_cloud_run_service" "srvone" {
  name     = var.srvone_name
  location = var.location
  template {
    metadata {
      annotations = {
        "run.googleapis.com/vpc-access-connector" = var.vpc_conn_id
        "run.googleapis.com/vpc-access-egress"    = "all-traffic"
      }
    }
    spec {
      containers {
        image = var.srvone_image
        env {
          name  = "SERVICE_TWO_URL"
          value = var.srvtwo_url
        }
      }
    }
  }
  traffic {
    percent         = 100
    latest_revision = true
  }
  lifecycle {
    ignore_changes = [
      template.0.metadata.0.annotations,
    ]
  }
}