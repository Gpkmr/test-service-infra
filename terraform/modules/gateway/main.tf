resource "google_api_gateway_api" "api" {
  provider = google-beta
  api_id   = var.api_id
  project  = var.project
}

/* data "template_file" "api-config-spec" {
  template = file("${path.module}/dev-api-config.yaml")
  vars = {
    service_one_url        = var.srvone_url
  }
} */

resource "google_api_gateway_api_config" "api_config" {
  provider      = google-beta
  project       = var.project
  api           = google_api_gateway_api.api.api_id
  api_config_id = var.config_id

  openapi_documents {
    document {
      path = "spec.yaml"
      #contents = filebase64("test-fixtures/apigateway/openapi.yaml")
      contents = base64encode(<<-EOF
        swagger: "2.0"
        info:
          title: dev-service-api
          description: "Get the service two status from service one"
          version: "1.0.0"
        schemes:
          - "https"
        paths:
          "/service":
            get:
              description: "Get service two status"
              operationId: "srv"
              x-google-backend:
                address: ${var.srvone_url}/one
              responses:
                200:
                  description: "Success."
                  schema:
                    type: string
                400:
                  description: "Something is wrong !"
          "/health":
            get:
              description: "Get health status of service one"
              operationId: "health"
              x-google-backend:
                address: ${var.srvone_url}/health
              responses:
                200:
                  description: "Success."
                  schema:
                    type: string
                400:
                  description: "Something is wrong !"
      EOF
      )
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "google_api_gateway_gateway" "api_gw" {
  provider   = google-beta
  project    = var.project
  api_config = google_api_gateway_api_config.api_config.id
  gateway_id = var.api_gw_id
  region     = var.location
}