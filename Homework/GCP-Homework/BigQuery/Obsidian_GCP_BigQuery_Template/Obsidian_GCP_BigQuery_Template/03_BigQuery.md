---
title: 03_BigQuery
---

# BigQuery Design

## Datasets
- `raw` — landings, external tables
- `curated` — cleaned & partitioned
- `marts` — BI-ready views

## Tables and Partitions
- Partition strategy (e.g., ingestion-time, DATE columns)
- Clustering keys (up to 4)

## Governance
- Data policies, column-level security, row access policies

## Related Terraform
- See `5-bigquery.tf` and `30-queries.tf` via [[05_Terraform_Files]].
