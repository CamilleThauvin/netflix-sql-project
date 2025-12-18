-- 03_revenue_metrics.sql
-- Analyses sur le revenu et les plans d'abonnement

-- 1) Dashboard revenu global
SELECT 'Clients actifs' AS metrique, COUNT(*)::text AS valeur
FROM customers WHERE is_active = TRUE

UNION ALL
SELECT 'Total clients', COUNT(*)::text FROM customers

UNION ALL
SELECT 'Taux churn %', 
       ROUND(100.0 * COUNT(CASE WHEN is_active = FALSE THEN 1 END)::numeric / COUNT(*), 1)::text
FROM customers

UNION ALL
SELECT 'CA mensuel €', 
       ROUND(SUM(sp.monthly_price), 2)::text
FROM customer_subscriptions cs 
JOIN subscription_plans sp ON cs.plan_id = sp.plan_id 
WHERE cs.is_current = TRUE

UNION ALL
SELECT 'CA annuel prévu €', 
       ROUND(SUM(sp.monthly_price * 12), 0)::text
FROM customer_subscriptions cs 
JOIN subscription_plans sp ON cs.plan_id = sp.plan_id 
WHERE cs.is_current = TRUE;

-- 2) Répartition des clients par plan (actuels)
SELECT 
    sp.plan_name,
    COUNT(cs.customer_id) AS nb_clients,
    ROUND(COUNT(cs.customer_id) * 100.0 / SUM(COUNT(cs.customer_id)) OVER (), 1) AS pourcentage
FROM customer_subscriptions cs
JOIN subscription_plans sp ON cs.plan_id = sp.plan_id
WHERE cs.is_current = TRUE
GROUP BY sp.plan_id, sp.plan_name
ORDER BY nb_clients DESC;
