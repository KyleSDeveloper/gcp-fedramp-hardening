# GCP FedRAMP-Style Hardening (Terraform, Project-Scoped)

**Goal:** show hands-on enforcement for FedRAMP-Moderate themes in GCP:
- Least privilege IAM (no “Editor” for apps)
- Private VPC posture (deny ingress by default)
- Audit Logging retention **≥ 90 days** (DFARS 7012)
- Project-scoped Org Policies (disable SA key creation, UBLA, disable serial console)
- Optional: **VPC Service Controls** + **Security Command Center** (org-level)

> This repo is designed to run with **project-level permissions**. VPC SC/SCC need org access and are **off by default**.

---

## Quickstart

### 0) Auth
```bash
gcloud auth application-default login
gcloud config set project <YOUR_PROJECT_ID>
export TF_VAR_project_id=<YOUR_PROJECT_ID>
```
### Init & apply
```bash
cd terraform
terraform init
terraform plan -var="project_id=$TF_VAR_project_id"
terraform apply -auto-approve -var="project_id=$TF_VAR_project_id"
```

### 2) What it does

- Creates Service Account app-sa with only:
    - `roles/logging.logWriter`, `roles/monitoring.metricWriter`
- Creates VPC secure-net with no inbound firewall
- Subnet secure-subnet with Private Google Access enabled
- Sets log retention on _Default bucket to 90 days
- Enforces project-scoped Org Policies (toggle via enable_org_policies):
    - `iam.disableServiceAccountKeyCreation`
    - `compute.disableSerialPortAccess`
    - `storage.uniformBucketLevelAccess`

### 3) Optional (org level)
- VPC Service Controls: set enable_vpc_sc=true, and pass org_id & access_policy_name
- Security Command Center: set enable_scc=true and pass org_id
If you don’t have org access, keep these off and include this repo as evidence of approach.

### 4) Destroy
```bash
terraform destroy -auto-approve -var="project_id=$TF_VAR_project_id"
```

## Evidence to screenshot (for an SSP/BoE)

1. **Logging retention** — Cloud Logging → Buckets → `_Default` shows **90 days**
2. **VPC** — VPC networks list shows `secure-net`; Firewall shows **no ingress allow** rules
3. **IAM** — Project IAM bindings for `app-sa@…` show only **logWriter/metricWriter**
4. **Org Policies (project level)** — Constraints page shows key controls **Enforced**
5. _(If enabled)_ **VPC SC** — Perimeter detail page (resources + restricted services)
6. _(If enabled)_ **SCC** — Org settings / notifications (or API enablement)

## Control Mapping (examples)
| NIST 800-53 (Mod)                 | What this repo shows                                                            |
| --------------------------------- | ------------------------------------------------------------------------------- |
| **AU-2 / AU-6** (Audit Logging)   | Cloud Audit Logs enabled by default; logs routed to `_Default`                  |
| **AU-11** (Retention)             | `_Default` bucket retention set to **90 days**                                  |
| **AC-2 / AC-6** (Least Privilege) | App SA with **minimal roles** (no Editor)                                       |
| **SC-7** (Boundary Protection)    | Private VPC, **deny ingress**, allow egress only                                |
| **CM-6** (Least Functionality)    | Project-scoped **Org Policies** (disable SA key creation; UBLA; disable serial) |
| **SI-4** (Monitoring)             | APIs enabled; Metric writer for app; room to add alerts/log-based metrics       |
| **SC-12/SC-13** (Optional)        | VPC Service Controls perimeter stub (org-level)                                 |
| **CA-7** (SCC – Optional)         | SCC stub & API enablement (org-level)                                           |

## Notes
- This is a starter: tailor VPC, firewall, sinks, alerting, CMEK, and inventory to your actual boundary.
- For a real FedRAMP build, pair these configs with a System Security Plan (SSP) and a Body of Evidence (BoE).


