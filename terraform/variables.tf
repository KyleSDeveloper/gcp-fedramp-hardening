variable "project_id" {
  description = "Target GCP project ID"
  type        = string
}

variable "region" {
  description = "Default region"
  type        = string
  default     = "us-central1"
}

variable "logging_retention_days" {
  description = "Retention for log buckets (DFARS 7012 >= 90d)"
  type        = number
  default     = 90
}

variable "enable_org_policies" {
  description = "Apply project-scoped org policies (no org-admin needed)"
  type        = bool
  default     = true
}

variable "enable_vpc_sc" {
  description = "Enable VPC Service Controls (requires org + access policy)"
  type        = bool
  default     = false
}

variable "enable_scc" {
  description = "Enable Security Command Center at org (requires org)"
  type        = bool
  default     = false
}

variable "org_id" {
  description = "Organization ID (digits). Required if enabling VPC SC or SCC"
  type        = string
  default     = ""
}

variable "access_policy_name" {
  description = "Access Context Manager policy name (e.g. organizations/123456789/policies/ACCESS_POLICY_ID)"
  type        = string
  default     = ""
}
