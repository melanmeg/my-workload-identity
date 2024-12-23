# resource "google_storage_bucket" "example" {
#   name          = "tfstate-bucket-melanmeg-my-1"
#   location      = "US"
#   uniform_bucket_level_access = true
#   force_destroy = true
# }

resource "google_project_iam_member" "owner" {
  project = "my-project-melanmeg"
  role    = "roles/owner"
  member  = "serviceAccount:terraform@wip-project-melanmeg.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "owner2" {
  project = "test-project-373118"
  role    = "roles/owner"
  member  = "serviceAccount:terraform@wip-project-melanmeg.iam.gserviceaccount.com"
}

resource "google_project_service" "iam_credentials_api" {
  project = "502820203034"  # プロジェクトIDを指定
  service = "iamcredentials.googleapis.com"
}

# これはエラーとなるが、残しておく
# resource "google_service_account_iam_member" "github" {
#   service_account_id = "projects/my-project-melanmeg/serviceAccounts/terraform@my-project-melanmeg.iam.gserviceaccount.com"
#   role               = "roles/workloadIdentityUser"
#   member             = "principalSet://iam.googleapis.com/projects/502820203034/locations/global/workloadIdentityPools/github-pool/attribute.repository/melanmeg/my-workload-identity"
# }
