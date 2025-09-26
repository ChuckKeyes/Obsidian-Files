---
title: 01_Project
---

# Project Overview

- **Project ID**: <!-- fill -->
- **Folder/Org**: <!-- fill -->
- **Billing Account**: <!-- fill -->
- **Regions**: Storage: <!-- e.g., us-east1 --> | BigQuery: <!-- e.g., US multi-region -->
- **Environment**: dev / test / prod
- **Naming Convention**: `{{env}}-{{workload}}-{{component}}`

## Architecture
- Staging bucket for CSV/Parquet in {ck-cloud-storage-bucket}/...
- BigQuery datasets for raw / curated / marts
- Deployer service account with least privilege
- APIs enabled (BigQuery, Storage, IAM, Cloud Resource Manager)

See: [[03_BigQuery]] and [[04_Service_Accounts_and_APIs]].
