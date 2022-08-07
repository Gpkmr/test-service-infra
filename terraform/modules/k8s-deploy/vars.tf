variable "deploy_name" {
  type    = string
  default = "service-two-deploy"
}

variable "svc_name" {
  type    = string
  default = "service-two-svc"
}

variable "image" {
  type    = string
  default = "us-east1-docker.pkg.dev/autodidact/registry-dev/srvtwo:latest"
}

variable "image_name" {
  type    = string
  default = "srvtwo"
}

variable "container_port" {
  type    = number
  default = 8082
}

variable "svc_port" {
  type    = number
  default = 80
}

variable "label" {
  type    = string
  default = "service-two"
}

variable "gke_endpoint" {
    type = string
}

variable "gke_cert" {
    type = string
}