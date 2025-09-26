
resource "google_service_account" "deployer" {
  account_id   = "bq-deployer"
  display_name = "BigQuery Deployer SA"
}

# Minimal useful roles for lab (tighten in prod)
resource "google_project_iam_member" "deployer_roles" {
  for_each = toset([
    "roles/bigquery.admin",
    "roles/storage.admin",
  ])
  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.deployer.email}"
}
