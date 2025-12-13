-- Revenue Top50 Users
-- Author: Yoshihiro Tsunoda
-- Date: 2025-12-12
-- Description: Retrieves the top 50 customers ranked by total spend, including purchase activity days.

SELECT
  user_pseudo_id AS user_id,
SUM(ecommerce.purchase_revenue) AS total_spend,
COUNT(DISTINCT event_date) AS active_days
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE ecommerce.purchase_revenue IS NOT NULL
GROUP BY user_id
ORDER BY total_spend DESC
LIMIT 50;