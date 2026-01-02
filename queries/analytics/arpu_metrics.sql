-- ARPU (Average Revenue Per User) et métriques abonnements
SELECT
    p.plan_name,
    p.monthly_price,
    COUNT(DISTINCT cs.customer_id) AS active_users,
    ROUND(
        COUNT(DISTINCT cs.customer_id) * 1.0 * p.monthly_price / 
        (SELECT COUNT(*) FROM customers),
        2
    ) AS arpu_contribution
FROM subscription_plans p
LEFT JOIN customer_subscriptions cs ON cs.plan_id = p.plan_id AND cs.is_current = TRUE
GROUP BY p.plan_id, p.plan_name, p.monthly_price
ORDER BY arpu_contribution DESC;
