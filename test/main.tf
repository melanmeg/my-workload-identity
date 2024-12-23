resource "google_storage_bucket" "example" {
  name          = "example-bucket-melanmeg-test-1"
  location      = "US"
  uniform_bucket_level_access = true
  force_destroy = true
}

# resource "google_project_iam_member" "owner" {
#   project = "test-project-373118"
#   role    = "roles/owner"
#   member  = "serviceAccount:terraform@wip-project-melanmeg.iam.gserviceaccount.com"
# }
