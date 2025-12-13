-- New vs Repeat Customers
-- Author: Yoshihiro Tsunoda
-- Date: 2025-12-12
-- Description: Segments customers into new (1 active day) and repeat users (2+ active days) and aggregates revenue by group.

WITH customer_activity AS (
SELECT
  user_pseudo_id AS user_id,
SUM(ecommerce.purchase_revenue) AS total_spend,
COUNT(DISTINCT event_date) AS active_days
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE ecommerce.purchase_revenue IS NOT NULL
GROUP BY user_id
)

SELECT
  active_days,
COUNT(*) AS user_count,
AVG(total_spend) AS avg_revenue
FROM customer_activity
GROUP BY active_days
ORDER BY active_days;