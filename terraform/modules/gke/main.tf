resource "google_container_cluster" "primary" {
  name                     = "tfm-dev-cluster"
  location                 = "us-central1-a"
  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = var.vpc_id
  subnetwork               = var.subnet_id

  default_max_pods_per_node = 110

  default_snat_status {
    disabled = false
  }

  networking_mode = "VPC_NATIVE"

  ip_allocation_policy {
    cluster_ipv4_cidr_block  = ""
    services_ipv4_cidr_block = ""
  }

  private_cluster_config {
    enable_private_endpoint = false
    enable_private_nodes    = true

    master_global_access_config {
      enabled = true
    }

    master_ipv4_cidr_block = "172.16.0.0/28"
  }
}

resource "google_container_node_pool" "tfm_nodes" {
  name       = "tfm-dev-ool"
  location   = "us-central1-a"
  cluster    = google_container_cluster.primary.name
  node_count = 3

  node_config {
    preemptible  = true
    machine_type = "e2-medium"

    oauth_scopes    = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
    service_account = "default"
  }
}