
-- Run in BigQuery console or bq CLI if you want SQL-only setup
CREATE SCHEMA IF NOT EXISTS `{{project_id}}.demo_ds` OPTIONS(location="{{bq_location}}");

CREATE TABLE IF NOT EXISTS `{{project_id}}.demo_ds.people`
(
  id STRING NOT NULL,
  full_name STRING NOT NULL,
  country STRING,
  certs ARRAY<STRING>,
  created_at TIMESTAMP
)
PARTITION BY DATE(created_at);
