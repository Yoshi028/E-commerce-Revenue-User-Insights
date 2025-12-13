-- Sales Distribution by Spend Range
-- Author: Yoshihiro Tsunoda
-- Date: 2025-12-12
-- Description: Categorizes customers into spend ranges and counts users within each spend bracket.

WITH customer_revenue AS (
SELECT
  user_pseudo_id AS user_id,
SUM(ecommerce.purchase_revenue) AS total_spend
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE ecommerce.purchase_revenue IS NOT NULL
GROUP BY user_id
),

bucketed AS (
SELECT
CASE
WHEN total_spend < 10 THEN '<10'
WHEN total_spend < 50 THEN '10-49'
WHEN total_spend < 100 THEN '50-99'
WHEN total_spend < 200 THEN '100-199'
ELSE '200+'
END AS spend_range,
COUNT(*) AS customer_count
FROM customer_revenue
GROUP BY spend_range
)

SELECT
  spend_range,
  customer_count
FROM bucketed
ORDER BY
CASE spend_range
WHEN '<10' THEN 1
WHEN '10-49' THEN 2
WHEN '50-99' THEN 3
WHEN '100-199' THEN 4
WHEN '200+' THEN 5
END;