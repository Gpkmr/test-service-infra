resource "google_compute_subnetwork" "custom-subnetwork" {
  name          = var.subnet_name
  ip_cidr_range = var.subnet_cidr
  region        = var.location

  stack_type               = "IPV4_ONLY"
  private_ip_google_access = true

  network = google_compute_network.custom-vpc.id
}

resource "google_compute_network" "custom-vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

resource "google_project_service" "vpcaccess_api" {
  service            = "vpcaccess.googleapis.com"
  project            = var.project
  provider           = google-beta
  disable_on_destroy = false
}

resource "google_vpc_access_connector" "connector" {
  name          = var.vpc_conn_name
  project       = var.project
  provider      = google-beta
  region        = var.location
  ip_cidr_range = var.vpc_conn_cidr
  network       = google_compute_network.custom-vpc.name
  depends_on    = [google_project_service.vpcaccess_api]
}