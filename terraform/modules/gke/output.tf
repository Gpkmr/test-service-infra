output "gke_endpoint" {
  value = google_container_cluster.primary.endpoint
}

output "gke_cert" {
    value = google_container_cluster.primary.master_auth.0.cluster_ca_certificate
}