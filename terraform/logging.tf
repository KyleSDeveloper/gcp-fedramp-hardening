# Enforce >= 90d retention on the default log bucket
resource "google_logging_project_bucket_config" "default_bucket" {
  project        = var.project_id
  location       = "global"
  retention_days = var.logging_retention_days
  bucket_id      = "_Default"
}

# Example: capture Admin Activity + Data Access logs are enabled by default in GCP.
# Optional: route a subset to another bucket or SIEM via sinks (left out for brevity).
