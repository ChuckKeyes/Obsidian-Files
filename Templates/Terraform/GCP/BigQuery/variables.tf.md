
variable "project_id" { type = string }
variable "region"     { type = string  default = "us-east1" }  # for regional services
variable "bq_location"{ type = string  default = "US" }        # BigQuery location: "US", "EU", or regional like "us-east4"

variable "dataset_id" { type = string  default = "demo_ds" }
variable "table_id"   { type = string  default = "people" }

variable "bucket_name" {
  type        = string
  description = "GCS bucket for data files (must be globally unique)"
  default     = "ck-bq-lab-data-bucket-change-me"
}

variable "labels" {
  type = map(string)
  default = { app = "bq-lab", env = "dev", owner = "chuck" }
}
