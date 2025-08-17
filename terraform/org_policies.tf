# These project-scoped Org Policies DO NOT require org-admin and are great “least privilege” signals.
# Toggle with var.enable_org_policies

resource "google_org_policy_policy" "disable_sa_key_creation" {
  count  = var.enable_org_policies ? 1 : 0
  name   = "projects/${var.project_id}/policies/iam.disableServiceAccountKeyCreation"
  parent = "projects/${var.project_id}"

  spec {
    rules {
      enforce = true
    }
  }
}

resource "google_org_policy_policy" "disable_serial_port" {
  count  = var.enable_org_policies ? 1 : 0
  name   = "projects/${var.project_id}/policies/compute.disableSerialPortAccess"
  parent = "projects/${var.project_id}"

  spec {
    rules { enforce = true }
  }
}

resource "google_org_policy_policy" "enforce_ubla" {
  count  = var.enable_org_policies ? 1 : 0
  name   = "projects/${var.project_id}/policies/storage.uniformBucketLevelAccess"
  parent = "projects/${var.project_id}"

  spec {
    rules { enforce = true }
  }
}
