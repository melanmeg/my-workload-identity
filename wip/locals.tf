locals {
  project_id = "wip-project-melanmeg"
  region     = "asia-northeast1"
  zones      = ["asia-northeast1-a"]

  repository = "melanmeg/my-workload-identity"

  workload_identity_pool_id          = "github-pool"
  workload_identity_pool_provider_id = "github-pool-provider"
}
