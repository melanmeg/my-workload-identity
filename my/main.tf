# resource "google_storage_bucket" "example" {
#   name          = "tfstate-bucket-melanmeg-my-1"
#   location      = "US"
#   uniform_bucket_level_access = true
#   force_destroy = true
# }

resource "google_service_account_iam_member" "owner" {
  service_account_id = google_service_account.github.name
  role               = "roles/owner"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github_pool.name}/attribute.repository/${local.repository}"
}

# これはエラーとなるが、残しておく
# resource "google_service_account_iam_member" "github" {
#   service_account_id = "projects/my-project-melanmeg/serviceAccounts/terraform@my-project-melanmeg.iam.gserviceaccount.com"
#   role               = "roles/workloadIdentityUser"
#   member             = "principalSet://iam.googleapis.com/projects/502820203034/locations/global/workloadIdentityPools/github-pool/attribute.repository/melanmeg/my-workload-identity"
# }
