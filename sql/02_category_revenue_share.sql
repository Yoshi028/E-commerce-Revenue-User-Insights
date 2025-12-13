-- Category Revenue Share
-- Author: Yoshihiro Tsunoda
-- Date: 2025-12-12
-- Description: Calculates total revenue by product category and computes category-level contribution.

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
),
total AS (
SELECT SUM(revenue) AS total_revenue FROM category_sales
)
SELECT
category,
revenue,
ROUND(revenue / total_revenue * 100, 2) AS revenue_share_percent
FROM
category_sales, total
ORDER BY
revenue DESC;