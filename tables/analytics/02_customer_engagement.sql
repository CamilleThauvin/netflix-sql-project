-- 02_customer_engagement.sql
-- Analyses sur les clients et leur engagement

-- 1) Nombre de clients actifs / inactifs
SELECT 
    COUNT(CASE WHEN is_active = TRUE THEN 1 END) AS clients_actifs,
    COUNT(CASE WHEN is_active = FALSE THEN 1 END) AS clients_inactifs,
    COUNT(*) AS total_clients
FROM customers;

-- 2) Taux de churn (clients inactifs / total)
SELECT 
    ROUND(100.0 * COUNT(CASE WHEN is_active = FALSE THEN 1 END)::numeric / COUNT(*), 1) AS churn_pourcent
FROM customers;

-- 3) Nombre moyen d'abonnements par client
SELECT 
    ROUND(AVG(nb_abos), 2) AS abonnements_moyens_par_client
FROM (
    SELECT customer_id, COUNT(*) AS nb_abos
    FROM customer_subscriptions
    GROUP BY customer_id
) t;
