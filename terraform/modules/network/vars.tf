variable "subnet_cidr" {
  type    = string
  default = "10.3.0.0/24"
}

variable "location" {
  type    = string
  default = "us-central1"
}

variable "project" {
  type    = string
  default = "autodidact"
}

variable "vpc_conn_cidr" {
  type    = string
  default = "10.8.0.0/28"
}

variable "vpc_name" {
  type    = string
  default = "dev-vpc"
}

variable "subnet_name" {
  type    = string
  default = "dev-gke-subnet"
}

variable "vpc_conn_name" {
  type    = string
  default = "dev-conn"
}
