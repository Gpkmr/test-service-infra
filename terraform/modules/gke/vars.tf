variable "vpc_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "gke_cluster_name" {
  type    = string
  default = "dev-cluster"
}

variable "gke_pool_name" {
  type    = string
  default = "dev-pool"
}

variable "location" {
  type    = string
  default = "us-central1"
}

variable "project" {
  type    = string
  default = "autodidact"
}

variable "gke_zone" {
  type    = string
  default = "us-central1-a"
}

variable "node_count" {
  type    = number
  default = 3
}

variable "gke_master_cidr" {
  type    = string
  default = "172.16.0.0/28"
}

variable "node_machine_type" {
  type    = string
  default = "e2-medium"
}