

---

## SNIPPET: `backend.tf` (state storage)
```hcl
# Edit bucket & prefix by hand (backends can't use variables)
terraform {
  backend "gcs" {
    bucket = "ck-tfstate-bq-lab" # <-- change to a globally-unique bucket you own
    prefix = "envs/dev"
  }
}
