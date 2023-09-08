## this enables the Cloud Run API service for our GCP project.
resource "google_project_service" "run_maxdrive" {
  service = var.service_run

  disable_on_destroy = false
}