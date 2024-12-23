resource "google_storage_bucket" "example" {
  name          = "example-bucket-melanmeg-my-1-tmp3"
  location      = "US"
  force_destroy = true
}
