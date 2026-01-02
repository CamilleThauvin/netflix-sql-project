-- Analyse churn : clients à risque + taux churn
-- 1. Taux de churn global
SELECT
    COUNT(*) FILTER (WHERE cs.customer_id IS NULL) * 100.0 / COUNT(*) AS churn_rate_pct,
    COUNT(*) FILTER (WHERE cs.customer_id IS NOT NULL) * 100.0 / COUNT(*) AS retention_rate_pct
FROM customers c
LEFT JOIN customer_subscriptions cs ON cs.customer_id = c.customer_id AND cs.is_current = TRUE;

-- 2. Clients churnés récemment (inscription < 30j)
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.signup_date,
    c.email
FROM customers c
LEFT JOIN customer_subscriptions cs ON cs.customer_id = c.customer_id AND cs.is_current = TRUE
WHERE cs.customer_id IS NULL
  AND c.signup_date >= CURRENT_DATE - INTERVAL '30 days';
