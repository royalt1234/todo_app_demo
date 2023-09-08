# this creates the public Todo_App cloud run service
resource "google_cloud_run_v2_service" "Todo_App" {
  name     = var.todo_app_name
  location = var.region

  template {
    containers {
      image = var.todo_app_image
      ports {
        container_port = 8080
      }
    }
  }
  depends_on = [google_project_service.run_maxdrive]
}

# manages the IAM policy/permissions for the Todo_App service
resource "google_cloud_run_v2_service_iam_member" "Todo_App" {
  project  = google_cloud_run_v2_service.Todo_App.project
  location = google_cloud_run_v2_service.Todo_App.location
  name     = google_cloud_run_v2_service.Todo_App.name
  role     = var.role
  member   = "allUsers"
}