resource "google_storage_bucket" "example" {
  name          = "example-bucket-melanmeg-test-1"
  location      = "US"
  force_destroy = true
}
