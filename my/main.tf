resource "google_storage_bucket" "example" {
  name          = "tfstate-bucket-melanmeg-my-1"
  location      = "US"

  uniform_bucket_level_access = true

  force_destroy = true
}

resource "google_service_account_iam_member" "owner" {
  service_account_id = "projects/${local.wip_project_id}/serviceAccounts/${local.service_account_name}"
  role               = "roles/owner"
  member             = "principalSet://iam.googleapis.com/${local.workload_identity_pool_name}/attribute.repository/${local.repository}"
}
