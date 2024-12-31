resource "google_iam_workload_identity_pool" "my_pool" {
  project                   = local.project_id
  workload_identity_pool_id = "my-pool"
}

############################################
# GitHub Pool Provider                     #
############################################
resource "google_iam_workload_identity_pool_provider" "github_pool_provider" {
  project                            = local.project_id
  workload_identity_pool_id          = google_iam_workload_identity_pool.my_pool.workload_identity_pool_id
  workload_identity_pool_provider_id = "github-pool-provider"
  display_name                       = "Github Pool Provider"
  description                        = "for Github Actions"
  attribute_mapping = {
    "google.subject"             = "assertion.sub"
    "attribute.repository"       = "assertion.repository"
    "attribute.repository_owner" = "assertion.repository_owner"
  }
  attribute_condition = "assertion.repository == 'melanmeg/my-workload-identity' || assertion.repository == 'melanmeg/my-k8s-app'"
  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}

resource "google_service_account" "github" {
  account_id   = "terraform"
}

resource "google_service_account_iam_member" "my-workload-identity_workload_identity_member" {
  service_account_id = google_service_account.github.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.my_pool.name}/attribute.repository/melanmeg/my-workload-identity"
}

resource "google_service_account_iam_member" "my-k8s-app_workload_identity_member" {
  service_account_id = google_service_account.github.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.my_pool.name}/attribute.repository/melanmeg/my-k8s-app"
}

# resource "google_service_account_iam_member" "owner" {
#   service_account_id = google_service_account.github.name
#   role               = "roles/owner"
#   member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github_pool.name}/attribute.repository/${local.repository}"
# }

resource "google_project_iam_member" "owner" {
  project = "my-project-melanmeg"
  role    = "roles/owner"
  member  = "serviceAccount:${google_service_account.github.email}"
}

# ############################################
# # External Secrets Pool Provider           #
# ############################################
data "local_file" "cluster_jwks" {
  filename = "${path.module}/cluster-jwks.json"
}

resource "google_iam_workload_identity_pool_provider" "home_kubernetes" {
  project                            = local.project_id
  workload_identity_pool_id          = google_iam_workload_identity_pool.my_pool.workload_identity_pool_id
  workload_identity_pool_provider_id = "home-kubernetes-pool-provider"
  display_name                       = "Home Kubernetes Pool Provider"
  description                        = "for Kubernetes in the home"
  attribute_mapping = {
    "google.subject"                 = "assertion.sub"
    "attribute.namespace"            = "assertion['kubernetes.io']['namespace']"
    "attribute.service_account_name" = "assertion['kubernetes.io']['serviceaccount']['name']"
    "attribute.pod"                  = "assertion['kubernetes.io']['pod']['name']"
  }
  attribute_condition = "assertion['kubernetes.io']['namespace'] == 'external-secrets'"
  oidc {
    issuer_uri = "https://kubernetes.default.svc.cluster.local"
    jwks_json  = data.local_file.cluster_jwks.content
  }
}

resource "google_service_account" "home_kubernetes" {
  account_id   = "external-secrets"
}

# ref: https://cloud.google.com/kubernetes-engine/docs/concepts/workload-identity?hl=ja#principal-id-examples
resource "google_service_account_iam_member" "ksa_workload_identity_user" {
  service_account_id = google_service_account.home_kubernetes.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.my_pool.name}/attribute.namespace/external-secrets"
}

resource "google_project_iam_member" "ksa_owner" {
  project = "my-project-melanmeg"
  role    = "roles/owner"
  member  = "serviceAccount:${google_service_account.home_kubernetes.email}"
}
