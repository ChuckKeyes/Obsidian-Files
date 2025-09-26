
output "dataset_ref"      { value = google_bigquery_dataset.ds.id }
output "table_ref"        { value = google_bigquery_table.people.id }
output "external_table"   { value = try(google_bigquery_table.people_ext.id, null) }
output "data_bucket_uri"  { value = "gs://${google_storage_bucket.data.name}" }
output "deployer_sa"      { value = google_service_account.deployer.email }
