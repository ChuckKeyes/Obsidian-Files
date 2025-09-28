
---
tags: [template, gcp, bigquery, terraform]
created: {{date:YYYY-MM-DD}}
updated: {{date:YYYY-MM-DD}}
---

# GCP BigQuery – Terraform Lab (Snippets)

> Use these copy-paste blocks as individual files in a Terraform folder.

## Folder scaffold

/bigquery-lab  
├─ backend.tf  
├─ providers.tf  
├─ variables.tf  
├─ terraform.tfvars  
├─ enable-apis.tf  
├─ deployer-sa.tf  
├─ storage.tf  
├─ bigquery.tf  
├─ outputs.tf  
├─ queries/  
│ ├─ 01_create_table.sql  
│ └─ 02_checks.sql  
└─ test-code/  
├─ bq_cli.sh  
└─ python_quickcheck.py