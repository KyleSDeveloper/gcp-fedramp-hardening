# Minimal private VPC, no inbound from the internet
resource "google_compute_network" "secure_net" {
  name                    = "secure-net"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "secure_subnet" {
  name                     = "secure-subnet"
  ip_cidr_range            = "10.10.0.0/24"
  region                   = var.region
  network                  = google_compute_network.secure_net.self_link
  private_ip_google_access = true # private Google API access
}

# Deny all ingress by default (new networks already deny; leave explicit)
resource "google_compute_firewall" "deny_all_ingress" {
  name    = "deny-all-ingress"
  network = google_compute_network.secure_net.name
  priority = 1000

  direction = "INGRESS"
  deny {
    protocol = "all"
  }
}

# Allow minimal egress (adjust per need)
resource "google_compute_firewall" "allow_all_egress" {
  name    = "allow-all-egress"
  network = google_compute_network.secure_net.name
  direction = "EGRESS"
  allow {
    protocol = "all"
  }
  priority = 1000
}
