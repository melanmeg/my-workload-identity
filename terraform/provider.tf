terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.1.0"
    }
  }
  backend "gcs" {
    bucket  = "wip-project-melanmeg-tfstate"
    prefix  = "wip-project-melanmeg/state"
  }
}

provider "google" {
  project        = local.project_id
  region         = local.region
  zone           = local.zones[0]
}
