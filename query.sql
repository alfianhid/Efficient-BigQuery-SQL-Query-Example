# Find the distinct rows
# distinct: 56.410 vs total:56.535
SELECT
  (SELECT COUNT(1) FROM (SELECT DISTINCT * FROM `data-to-insights.ecommerce.rev_transactions`)) AS distinct_rows,
  (SELECT COUNT(1) FROM `data-to-insights.ecommerce.rev_transactions`) AS total_rows;

# Select the distinct rows only
CREATE OR REPLACE TABLE `data-fellowship-batch-7.practical_case_session_3.cleaned`
AS
SELECT
DISTINCT *
FROM `data-to-insights.ecommerce.rev_transactions`;