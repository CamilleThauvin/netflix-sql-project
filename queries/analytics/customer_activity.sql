-- Répartition des clients actifs vs inactifs
SELECT
    is_active,
    COUNT(*) AS customers_count
FROM customers
GROUP BY is_active;


-- Clients sans abonnement actif (churn simple)
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email
FROM customers c
LEFT JOIN customer_subscriptions cs
    ON cs.customer_id = c.customer_id
   AND cs.is_current = TRUE
WHERE cs.customer_id IS NULL;
