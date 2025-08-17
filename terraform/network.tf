resource "google_compute_network" "secure_net" {
  name                    = "secure-net"
  auto_create_subnetworks = false
  depends_on              = [google_project_service.core["compute.googleapis.com"]]
}

resource "google_compute_subnetwork" "secure_subnet" {
  name                     = "secure-subnet"
  region                   = "us-central1"
  ip_cidr_range            = "10.10.0.0/24"
  network                  = google_compute_network.secure_net.id
  private_ip_google_access = true
}

# Explicit deny-all ingress (evidence; GCP denies by default)
resource "google_compute_firewall" "deny_all_ingress" {
  name      = "deny-all-ingress"
  network   = google_compute_network.secure_net.id
  direction = "INGRESS"
  priority  = 1000

  deny {
    protocol = "all"
  }

  # REQUIRED for ingress rules
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_all_egress" {
  name      = "allow-all-egress"
  network   = google_compute_network.secure_net.id
  direction = "EGRESS"
  priority  = 1000

  allow {
    protocol = "all"
  }

  destination_ranges = ["0.0.0.0/0"]
}
