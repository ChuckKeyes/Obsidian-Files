---
title: 07_Deploy_Runbook
---

# Deploy & Operate

## First-time bootstrap
1. Create/attach billing to project
2. `terraform init`
3. `terraform plan -out=tf.plan`
4. `terraform apply tf.plan`

## Updates
- Use feature branches, pull request reviews
- `terraform plan` in CI before merge

## Drift & Break-glass
- `terraform refresh` / `terraform plan`
- Export IAM policy for diff
- Rollback via previous plan/apply logs
