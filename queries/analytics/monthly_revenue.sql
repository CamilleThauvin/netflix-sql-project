-- REVENUS MENSUELS & DASHBOARD

-- 1) Dashboard global des revenus
SELECT 'Clients actifs' AS metrique, COUNT(*)::text AS valeur
FROM customers WHERE is_active = TRUE
UNION ALL
SELECT 'CA mensuel €', ROUND(SUM(sp.monthly_price), 2)::text
FROM customer_subscriptions cs
JOIN subscription_plans sp ON cs.plan_id = sp.plan_id
WHERE cs.is_current = TRUE
UNION ALL
SELECT 'CA annuel €', ROUND(SUM(sp.monthly_price * 12), 0)::text
FROM customer_subscriptions cs
JOIN subscription_plans sp ON cs.plan_id = sp.plan_id
WHERE cs.is_current = TRUE;

-- 2) Chiffre d'affaires par plan d'abonnement
SELECT
    sp.plan_name,
    COUNT(cs.customer_id) AS nb_clients,
    ROUND(SUM(sp.monthly_price), 2) AS ca_mensuel,
    ROUND(SUM(sp.monthly_price * 12), 2) AS ca_annuel_projete
FROM customer_subscriptions cs
JOIN subscription_plans sp ON cs.plan_id = sp.plan_id
WHERE cs.is_current = TRUE
GROUP BY sp.plan_id, sp.plan_name
ORDER BY ca_mensuel DESC;
