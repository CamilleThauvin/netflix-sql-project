-- REVENUS MENSUELS & DASHBOARD

-- 1) Dashboard global
SELECT 'Clients actifs' AS metrique, COUNT(*)::text AS valeur
FROM customers WHERE is_active = TRUE
UNION ALL
SELECT 'CA mensuel €', ROUND(SUM(sp.monthly_price), 2)::text
FROM customer_subscriptions cs JOIN subscription_plans sp ON cs.plan_id = sp.plan_id WHERE cs.is_current = TRUE
UNION ALL
SELECT 'CA annuel €', ROUND(SUM(sp.monthly_price * 12), 0)::text
FROM customer_subscriptions cs JOIN subscription_plans sp ON cs.plan_id = sp.plan_id WHERE cs.is_current = TRUE;

-- 2) CA par plan
SELECT sp.plan_name, COUNT(cs.customer_id) AS nb_clients, 
       ROUND(SUM(sp.monthly_price), 2) AS ca_mensuel
FROM customer_subscriptions cs JOIN subscription_plans sp ON cs.plan_id = sp.plan_id 
WHERE cs.is_current = TRUE
GROUP BY sp.plan_id, sp.plan_name;


-- REVENUS MENSUELS & DASHBOARD

-- 1) Dashboard global
SELECT 'Clients actifs' AS metrique, COUNT(*)::text AS valeur
FROM customers WHERE is_active = TRUE
UNION ALL
SELECT 'CA mensuel €', ROUND(SUM(sp.monthly_price), 2)::text
FROM customer_subscriptions cs JOIN subscription_plans sp ON cs.plan_id = sp.plan_id WHERE cs.is_current = TRUE;

-- 2) CA par plan
SELECT sp.plan_name, COUNT(cs.customer_id) AS nb_clients, 
       ROUND(SUM(sp.monthly_price), 2) AS ca_mensuel
FROM customer_subscriptions cs JOIN subscription_plans sp ON cs.plan_id = sp.plan_id 
WHERE cs.is_current = TRUE
GROUP BY sp.plan_id, sp.plan_name;
