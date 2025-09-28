

-- Basic checks
SELECT COUNT(*) AS row_count FROM `{{project_id}}.demo_ds.people`;

-- Find recent rows
SELECT * FROM `{{project_id}}.demo_ds.people`
WHERE created_at >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 7 DAY)
ORDER BY created_at DESC
LIMIT 50;
