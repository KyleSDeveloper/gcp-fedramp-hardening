output "project_id" {
  value = var.project_id
}

output "app_service_account" {
  value = google_service_account.app.email
}

output "vpc_name" {
  value = google_compute_network.secure_net.name
}

output "subnet_name" {
  value = google_compute_subnetwork.secure_subnet.name
}

output "log_retention_days" {
  value = var.logging_retention_days
}
