locals {
  project_id = "my-project-melanmeg"
  region     = "asia-northeast1"
  zones      = ["asia-northeast1-a"]

  repository = "melanmeg/my-workload-identity"
  workload_identity_pool_name = "projects/my-project-melanmeg/locations/global/workloadIdentityPools/github-pool"
}
