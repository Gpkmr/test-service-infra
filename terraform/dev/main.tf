terraform {
  required_version = ">=1.0"
  required_providers {
    google = "~> 4.0"
  }
}

provider "google" {
  project = "autodidact"
  region  = "us-central1"
}

module "network-data" {
  source = "../modules/network"
}

module "gke" {
  source = "../modules/gke"
  vpc_id = module.network-data.vpc_id
  subnet_id = module.network-data.subnet_id
}

module "serverless" {
  source = "../modules/serverless"
  vpc_conn_id = module.network-data.vpc_conn_id
}

/* resource "google_compute_subnetwork" "custom-subnetwork" {
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

resource "google_container_cluster" "primary" {
  name                     = "tfm-dev-cluster"
  location                 = "us-central1-a"
  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = google_compute_network.custom-vpc.id
  subnetwork               = google_compute_subnetwork.custom-subnetwork.id

  #cluster_ipv4_cidr = "10.132.0.0/14"

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
    # run.googleapis.com/vpc-access-connector: projects/autodidact/locations/us-central1/connectors/dev-connector
    annotations = {
      "run.googleapis.com/vpc-access-connector" = google_vpc_access_connector.connector.id
      "run.googleapis.com/vpc-access-egress"    = "all-traffic"
    }
  }

  lifecycle {
    ignore_changes = [
        metadata.0.annotations,
    ]
  }
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
} */