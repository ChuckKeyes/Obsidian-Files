
# 1) Auth
gcloud auth application-default login
gcloud config set project <PROJECT_ID>

# 2) Terraform init & apply
terraform init
terraform apply -auto-approve

# 3) (Optional) Upload seed CSVs then query
gsutil -m cp ./samples/*.csv gs://<your-bucket>/seed/


[!tip] Where to put secrets
Keep secrets out of TF files. Use gcloud auth application-default login for local dev, and Workload Identity or SA keys in Secret Manager for CI (never commit keys).