resource "google_storage_bucket" "tfstate_bucket" {
  project       = local.project_id
  name          = "${local.project_id}-tfstate"
  location      = local.region
  storage_class = "REGIONAL"
  force_destroy = false

  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }

  lifecycle_rule {
    action {
      type          = "Delete"
      storage_class = ""
    }
    condition {
      num_newer_versions = 10
    }
  }
}
