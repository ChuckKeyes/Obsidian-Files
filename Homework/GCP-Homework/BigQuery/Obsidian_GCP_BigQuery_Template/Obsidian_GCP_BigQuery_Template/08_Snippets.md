---
title: 08_Snippets
---

# Reusable Snippets

## Enable APIs (module-friendly)
```hcl
resource "google_project_service" "required" {
  for_each = toset([
    "bigquery.googleapis.com",
    "storage.googleapis.com",
    "iam.googleapis.com",
    "cloudresourcemanager.googleapis.com",
  ])
  project                 = var.project_id
  service                 = each.key
  disable_on_destroy      = false
  disable_dependent_services = false
}
```

## SA with least privilege (bootstrap then narrow)
```hcl
resource "google_service_account" "deployer" {
  account_id   = "tf-deployer"
  display_name = "Terraform Deployer"
}
```

## BigQuery dataset
```hcl
resource "google_bigquery_dataset" "raw" {
  dataset_id                  = "raw"
  location                    = var.bq_location
  delete_contents_on_destroy  = false
}
```

## External table (GCS)
```hcl
resource "google_bigquery_table" "ext_raw" {
  dataset_id = google_bigquery_dataset.raw.dataset_id
  table_id   = "ext_raw"
  external_data_configuration {
    source_uris = ["gs://${var.bucket}/raw/*.csv"]
    source_format = "CSV"
    csv_options {{'{'}}
      skip_leading_rows = 1
      allow_jagged_rows = true
    {{'}'}}
  }
}
```

## Partitioned native table
```hcl
resource "google_bigquery_table" "events" {
  dataset_id = google_bigquery_dataset.curated.dataset_id
  table_id   = "events"
  time_partitioning {{'{'}}
    type  = "DAY"
    field = "event_date"
  {{'}'}}
  clustering = ["user_id", "country"]
}
```
