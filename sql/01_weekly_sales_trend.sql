-- Weekly Sales Trend
-- Author: Yoshihiro Tsunoda
-- Date: 2025-12-12
-- Description: Aggregates revenue by week

SELECT
  EXTRACT(ISOYEAR FROM PARSE_DATE('%Y%m%d', event_date)) AS year,
  EXTRACT(ISOWEEK FROM PARSE_DATE('%Y%m%d', event_date)) AS week,
  SUM(ecommerce.purchase_revenue) AS weekly_revenue
FROM
  `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE
  ecommerce.purchase_revenue IS NOT NULL
GROUP BY
  year, week
ORDER BY
  year, week;