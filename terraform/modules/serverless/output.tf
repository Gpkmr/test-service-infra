output "srv_run_url" {
  value = google_cloud_run_service.srvone.status[0].url
}