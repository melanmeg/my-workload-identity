locals {
  region              = "asia-northeast1"
  zones               = ["asia-northeast1-a"]
  project_id          = "wip-project-melanmeg"

  workload_identity_pool_id          = "github-pool"
  workload_identity_pool_provider_id = "github-pool-provider"
}
