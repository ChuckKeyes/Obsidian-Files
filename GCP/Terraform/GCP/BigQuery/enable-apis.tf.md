
resource "google_project_service" "services" {
  for_each = toset([
    "bigquery.googleapis.com",
    "storage.googleapis.com",
    "iam.googleapis.com",
    "cloudresourcemanager.googleapis.com",
  ])
  project = var.project_id
  service = each.value
  disable_on_destroy = false
}
