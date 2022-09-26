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

# Create an efficient query which derives
# the total transactions per date and country
# based on the channel grouping
SELECT
  channelGrouping,
  date,
  geoNetwork_country,
  SUM(totals_transactions) AS totalTransactions
FROM `data-fellowship-batch-7.practical_case_session_3.cleaned`
GROUP BY channelGrouping, date, geoNetwork_country
ORDER BY channelGrouping ASC;

# Create the repeated column
CREATE OR REPLACE TABLE `data-fellowship-batch-7.practical_case_session_3.repeated_column`
AS
SELECT
  channelGrouping,
  geoNetwork_country,
  date,
  SUM(totals_transactions) AS totalTransactions
FROM `data-fellowship-batch-7.practical_case_session_3.cleaned`
GROUP BY channelGrouping, geoNetwork_country, date
ORDER BY channelGrouping, geoNetwork_country, date ASC;

# Create the nested column
SELECT
  channelGrouping,
  geoNetwork_country,
  ARRAY_AGG(date ORDER BY date) AS transaction_date,
  ARRAY_AGG(totalTransactions ORDER BY totalTransactions) AS totalTransactions
FROM `data-fellowship-batch-7.practical_case_session_3.repeated_column`
GROUP BY channelGrouping, geoNetwork_country
ORDER BY channelGrouping;