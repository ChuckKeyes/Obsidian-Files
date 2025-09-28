
from google.cloud import bigquery
import os, sys

project = sys.argv[1] if len(sys.argv) > 1 else os.environ.get("GOOGLE_CLOUD_PROJECT")
client = bigquery.Client(project=project)

sql = """
SELECT country, COUNT(*) c
FROM `{}.demo_ds.people`
GROUP BY country
ORDER BY c DESC
LIMIT 10
""".format(project)

for row in client.query(sql):
    print(f"{row.country or 'UNKNOWN'}\t{row.c}")
