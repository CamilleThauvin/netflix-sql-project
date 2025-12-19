-- Nombre de changements de plan par client
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(cs.customer_subscription_id) - 1 AS plan_changes_count
FROM customer_subscriptions cs
JOIN customers c
    ON c.customer_id = cs.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
HAVING
    COUNT(cs.customer_subscription_id) > 1
ORDER BY
    plan_changes_count DESC;

