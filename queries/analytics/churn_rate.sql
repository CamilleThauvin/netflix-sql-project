-- CHURN RATE & ENGAGEMENT CLIENTS

-- 1) Clients actifs vs inactifs
SELECT
    COUNT(CASE WHEN is_active = TRUE THEN 1 END) AS clients_actifs,
    COUNT(CASE WHEN is_active = FALSE THEN 1 END) AS clients_inactifs,
    COUNT(*) AS total_clients
FROM customers;

-- 2) Taux de churn
SELECT
    ROUND(100.0 * COUNT(CASE WHEN is_active = FALSE THEN 1 END)::numeric / COUNT(*), 1) AS churn_pourcent
FROM customers;
