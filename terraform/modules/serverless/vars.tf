variable "vpc_conn_id" {
  type = string
}

variable "location" {
  type    = string
  default = "us-central1"
}

variable "project" {
  type    = string
  default = "autodidact"
}

variable "srvone_image" {
  type = string
  #us-east1-docker.pkg.dev/autodidact/registry-dev/srvone:latest
}

variable "srvtwo_url" {
  type = string
  #http://10.3.0.11:80/two
}

variable "srvone_name" {
  type    = string
  default = "service-one-dev"
}