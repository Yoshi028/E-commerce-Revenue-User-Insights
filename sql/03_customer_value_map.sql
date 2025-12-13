-- Customer Value Map (AOV × Purchase Frequency)
-- Author: Yoshihiro Tsunoda
-- Date: 2025-12-12
-- Description: Computes total spend, average order value (AOV), and purchase frequency per customer.

WITH customer_stats AS (
SELECT
user_pseudo_id AS user_id,
SUM(ecommerce.purchase_revenue) AS total_spend,
COUNT(DISTINCT event_date) AS active_days,
SUM(ecommerce.purchase_revenue) / COUNT(DISTINCT event_date) AS avg_order_value
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE ecommerce.purchase_revenue IS NOT NULL
GROUP BY user_id
)

SELECT *
FROM customer_stats
ORDER BY total_spend DESC;