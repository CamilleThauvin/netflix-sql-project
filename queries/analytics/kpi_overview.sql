-- KPIs globaux : clients, abonnements actifs, temps total de visionnage
SELECT
    (SELECT COUNT(*) FROM customers) AS total_customers,
    (SELECT COUNT(*) FROM customer_subscriptions WHERE is_current = TRUE) AS active_subscriptions,
    (SELECT COUNT(*) FROM streaming_sessions) AS total_sessions,
    (SELECT COALESCE(SUM(session_duration_minutes), 0) FROM streaming_sessions) AS total_watch_time_minutes;
