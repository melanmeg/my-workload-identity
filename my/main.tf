# resource "google_storage_bucket" "example" {
#   name          = "example-bucket-melanmeg-my-1-tmp5"
#   location      = "US"
#   force_destroy = true
# }

resource "google_service_account_iam_member" "owner" {
  service_account_id = "projects/${local.wip_project_id}/serviceAccounts/${local.service_account_name}"
  role               = "roles/owner"
  member             = "principalSet://iam.googleapis.com/${local.workload_identity_pool_name}/attribute.repository/${local.repository}"
}
