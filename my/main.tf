resource "google_storage_bucket" "example" {
  name          = "tfstate-bucket-melanmeg-my-1"
  location      = "US"

  uniform_bucket_level_access = true

  force_destroy = true
}

resource "google_service_account" "github" {
  account_id   = "terraform"
}

resource "google_service_account_iam_member" "workload_identity_member" {
  service_account_id = google_service_account.github.name
  role               = "roles/owner"
  member             = "principalSet://iam.googleapis.com/${local.workload_identity_pool_name}/attribute.repository/${local.repository}"
}

resource "google_service_account_iam_member" "owner" {
  service_account_id = google_service_account.github.name
  role               = "roles/owner"
  member             = "principalSet://iam.googleapis.com/${local.workload_identity_pool_name}/attribute.repository/${local.repository}"
}
