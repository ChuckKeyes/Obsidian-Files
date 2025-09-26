---
title: 02_Storage
---

# Cloud Storage

- **Buckets**: document names, locations, lifecycle policies
- **Folder layout**: `/raw/`, `/curated/`, `/tmp/`
- **Permissions**: SA access, data admin vs object admin

## Related Terraform
- [[05_Terraform_Files]] → `0-storage.tf`

### Notes / Decisions
- Multipart uploads? Lifecycle to move to Nearline?
