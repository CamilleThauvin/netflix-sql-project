-- Nombre de changements de plan par client
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    COUNT(cs.customer_subscription_id) AS total_subscriptions,
    COUNT(cs.customer_subscription_id) - 1 AS plan_changes_count,
    CASE
        WHEN COUNT(cs.customer_subscription_id) = 1 THEN 'Aucun changement'
        WHEN COUNT(cs.customer_subscription_id) = 2 THEN '1 changement'
        ELSE CAST(COUNT(cs.customer_subscription_id) - 1 AS VARCHAR) || ' changements'
    END AS status
FROM customer_subscriptions cs
JOIN customers c
    ON c.customer_id = cs.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email
ORDER BY
    plan_changes_count DESC,
    c.customer_id;
