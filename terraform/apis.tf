# Enable core APIs for this project
locals {
  project_services = [
    "iam.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "compute.googleapis.com",
    "serviceusage.googleapis.com",
    "cloudresourcemanager.googleapis.com"
    # Optional / org-level (only if you later enable those sections)
    # "accesscontextmanager.googleapis.com",
    # "securitycenter.googleapis.com",
  ]
}

resource "google_project_service" "core" {
  for_each           = toset(local.project_services)
  project            = var.project_id
  service            = each.key
  disable_on_destroy = false
}
