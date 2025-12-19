-- Revenu mensuel théorique par plan (abonnements actuels)
SELECT
    p.plan_id,
    p.plan_name,
    p.monthly_price,
    COUNT(cs.customer_id) AS active_subscribers_count,
    COUNT(cs.customer_id) * p.monthly_price AS monthly_revenue
FROM subscription_plans p
LEFT JOIN customer_subscriptions cs
    ON cs.plan_id = p.plan_id
   AND cs.is_current = TRUE
GROUP BY
    p.plan_id,
    p.plan_name,
    p.monthly_price
ORDER BY
    monthly_revenue DESC;
