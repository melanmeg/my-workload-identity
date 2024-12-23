locals {
  project_id = "test-project-373118"
  region     = "asia-northeast1"
  zones      = ["asia-northeast1-a"]

  repository = "melanmeg/my-workload-identity"
  service_account_name = "terraform@wip-project-melanmeg.iam.gserviceaccount.com"
  workload_identity_pool_name = "projects/502820203034/locations/global/workloadIdentityPools/github-pool"
}
