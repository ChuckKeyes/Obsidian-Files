---
title: 04_Service_Accounts_and_APIs
---

# Service Accounts & APIs

## Deployer SA
- Name/email: <!-- fill -->
- Roles granted: least-privilege list (e.g., bigquery.admin for bootstrap then reduce)

## Enabled APIs
- bigquery.googleapis.com
- storage.googleapis.com
- cloudresourcemanager.googleapis.com
- iam.googleapis.com

## Related Terraform
- `15-Deployer-SA.tf`
- `20-enable-APIs.tf`
