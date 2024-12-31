resource "google_project_service" "enabled_apis" {
  for_each = toset([
    "cloudkms.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "iam.googleapis.com",
    "iamcredentials.googleapis.com",
    "secretmanager.googleapis.com",
    "storage.googleapis.com",
  ])
  project = "my-project-melanmeg"
  service = each.key
  disable_on_destroy = true
}
