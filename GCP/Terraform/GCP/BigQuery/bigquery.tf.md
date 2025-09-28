
resource "google_bigquery_dataset" "ds" {
  dataset_id                  = var.dataset_id
  location                    = var.bq_location
  delete_contents_on_destroy  = true
  labels                      = var.labels
}

# Inline schema example
locals {
  people_schema = jsonencode([
    { name = "id",        type = "STRING", mode = "REQUIRED" },
    { name = "full_name", type = "STRING", mode = "REQUIRED" },
    { name = "country",   type = "STRING", mode = "NULLABLE" },
    { name = "certs",     type = "STRING", mode = "REPEATED" },
    { name = "created_at",type = "TIMESTAMP", mode = "NULLABLE" }
  ])
}

resource "google_bigquery_table" "people" {
  dataset_id          = google_bigquery_dataset.ds.dataset_id
  table_id            = var.table_id
  deletion_protection = false
  schema              = local.people_schema

  time_partitioning {
    type  = "DAY"
    field = "created_at"
  }

  labels = var.labels
}

# OPTIONAL: External table over CSVs in GCS
resource "google_bigquery_table" "people_ext" {
  dataset_id          = google_bigquery_dataset.ds.dataset_id
  table_id            = "${var.table_id}_ext"
  deletion_protection = false

  external_data_configuration {
    autodetect    = true
    source_format = "CSV"
    source_uris   = ["gs://${google_storage_bucket.data.name}/seed/*.csv"]

    csv_options {
      skip_leading_rows = 1
      quote             = "\""
      field_delimiter   = ","
      allow_quoted_newlines = true
    }
  }

  labels = var.labels
}
