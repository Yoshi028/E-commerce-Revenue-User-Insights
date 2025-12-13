-- Pareto Analysis: Revenue Concentration by User
-- Author: Yoshihiro Tsunoda
-- Date: 2025-12-12
-- Description: Ranks customers by revenue and computes cumulative revenue ratio to evaluate concentration levels.

WITH customer_revenue AS (
SELECT
  user_pseudo_id AS user_id,
SUM(ecommerce.purchase_revenue) AS total_spend
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE ecommerce.purchase_revenue IS NOT NULL
GROUP BY user_id
),

ordered AS (
SELECT
  user_id,
  total_spend,
PERCENT_RANK() OVER (ORDER BY total_spend) AS pct_rank,
SUM(total_spend) OVER () AS total_revenue,
SUM(total_spend) OVER (ORDER BY total_spend) AS cumulative_revenue
FROM customer_revenue
)

SELECT
  user_id,
  total_spend,
  pct_rank,
  cumulative_revenue / total_revenue AS cumulative_revenue_ratio
FROM ordered
ORDER BY total_spend DESC;