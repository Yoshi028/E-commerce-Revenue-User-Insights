-- Lowest Revenue Categories
-- Author: Yoshihiro Tsunoda
-- Date: 2025-12-12
-- Extracts the bottom 5 product categories ranked by total revenue.

WITH category_sales AS (
SELECT
  item.item_category AS category,
SUM(item.price * item.quantity) AS revenue
FROM
  `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`,
UNNEST(items) AS item
WHERE
  ecommerce.purchase_revenue IS NOT NULL
GROUP BY
  category
)
SELECT *
FROM category_sales
ORDER BY revenue ASC
LIMIT 5;