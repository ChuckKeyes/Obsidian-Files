
#!/usr/bin/env bash
set -euo pipefail
PROJECT="${1:?project id required}"

# Create dataset (CLI route)
bq --project_id="$PROJECT" --location=US mk --dataset --if_not_exists demo_ds

# Load sample CSV to external table path
gsutil -m cp ./samples/people.csv gs://ck-bq-lab-data-bucket-12345/seed/  # change bucket

# Quick query
bq query --project_id="$PROJECT" --use_legacy_sql=false '
SELECT full_name, country
FROM `'"$PROJECT"'".demo_ds.people
ORDER BY full_name
LIMIT 10;'
