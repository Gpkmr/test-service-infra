terraform {
  required_version = ">=1.0"
  backend "gcs" {
    bucket = "autodidact-tf-state-dev"
    prefix = "terraform/state"
  }
  required_providers {
    google = "~> 4.0"
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.12.1"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.location
}

provider "google-beta" {
  project = var.project
}

module "network-data" {
  source = "../modules/network"
}

module "gke" {
  source    = "../modules/gke"
  vpc_id    = module.network-data.vpc_id
  subnet_id = module.network-data.subnet_id
}

module "serverless" {
  source       = "../modules/serverless"
  vpc_conn_id  = module.network-data.vpc_conn_id
  srvone_image = var.srvone_image
  srvtwo_url   = "http://${module.k8s-deploy.internal_lb_ip}:${var.svc_port}/two"
}

module "api-gateway" {
  source     = "../modules/gateway"
  srvone_url = module.serverless.srv_run_url
}

module "k8s-deploy" {
  source       = "../modules/k8s-deploy"
  gke_endpoint = module.gke.gke_endpoint
  gke_cert     = module.gke.gke_cert
  svc_port     = var.svc_port
}