resource "google_compute_subnetwork" "custom-subnetwork" {
  name = "tfm-subnet"

  ip_cidr_range = "10.3.0.0/24"
  region        = "us-central1"

  stack_type               = "IPV4_ONLY"
  private_ip_google_access = true

  network = google_compute_network.custom-vpc.id
}

resource "google_compute_network" "custom-vpc" {
  name                    = "tfm-vpc"
  auto_create_subnetworks = false
}

resource "google_project_service" "vpcaccess_api" {
  service            = "vpcaccess.googleapis.com"
  project            = "autodidact"
  provider           = google-beta
  disable_on_destroy = false
}

resource "google_vpc_access_connector" "connector" {
  name          = "dev-conn"
  project       = "autodidact"
  provider      = google-beta
  region        = "us-central1"
  ip_cidr_range = "10.8.0.0/28"
  network       = google_compute_network.custom-vpc.name
  depends_on    = [google_project_service.vpcaccess_api]
}