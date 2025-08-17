# Least-privilege app Service Account (no editor)
resource "google_service_account" "app" {
  account_id   = "app-sa"
  display_name = "App Service Account (least-privilege)"
}

# Minimal roles for typical app logging/metrics (adjust as needed)
resource "google_project_iam_member" "app_log_writer" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.app.email}"
}

resource "google_project_iam_member" "app_metric_writer" {
  project = var.project_id
  role    = "roles/monitoring.metricWriter"
  member  = "serviceAccount:${google_service_account.app.email}"
}

# (Optional example) read-only access to a single storage bucket you might create
# resource "google_project_iam_member" "app_storage_viewer" {
#   project = var.project_id
#   role    = "roles/storage.objectViewer"
#   member  = "serviceAccount:${google_service_account.app.email}"
# }
