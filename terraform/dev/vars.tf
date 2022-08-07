variable "srvone_image" {
  type    = string
  default = "us-east1-docker.pkg.dev/autodidact/registry-dev/srvone:latest"
}

variable "srvtwo_url" {
  type    = string
  default = "http://10.3.0.11:80/two"
}

variable "svc_port" {
  type    = number
  default = 80
}