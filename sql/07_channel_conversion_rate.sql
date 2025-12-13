-- Traffic Channel Conversion Rate Comparison
-- Author: Yoshihiro Tsunoda
-- Date: 2025-12-12
-- Description: Computes conversion rate (purchase_count / total_events) for each traffic channel.

SELECT
  traffic_source.name AS channel,
COUNTIF(ecommerce.purchase_revenue IS NOT NULL) AS purchase_count,
COUNT(*) AS total_events,
SAFE_DIVIDE(
COUNTIF(ecommerce.purchase_revenue IS NOT NULL),
COUNT(*)
) AS conversion_rate
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
GROUP BY channel
ORDER BY conversion_rate DESC;