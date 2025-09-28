
resource "google_storage_bucket" "data" {
  name          = var.bucket_name
  location      = var.region
  storage_class = "STANDARD"

  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"
  versioning { enabled = true }

  labels = var.labels
  force_destroy = true # delete objects with bucket (lab only)
}
