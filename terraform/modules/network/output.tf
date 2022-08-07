output "vpc_id" {
  value = google_compute_network.custom-vpc.id
}

output "subnet_id" {
  value = google_compute_subnetwork.custom-subnetwork.id
}

output "vpc_conn_id" {
  value = google_vpc_access_connector.connector.id
}