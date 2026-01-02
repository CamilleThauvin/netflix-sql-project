-- Temps de visionnage moyen par abonné et par plan
SELECT
    p.plan_name,
    p.monthly_price,
    COUNT(DISTINCT cs.customer_id) AS subscribers_count,
    COUNT(s.session_id) AS total_sessions,
    COALESCE(SUM(s.session_duration_minutes), 0) AS total_watch_time_minutes,
    CASE 
        WHEN COUNT(DISTINCT cs.customer_id) = 0 THEN 0
        ELSE ROUND(
            1.0 * COALESCE(SUM(s.session_duration_minutes), 0)
            / COUNT(DISTINCT cs.customer_id),
            1
        )
    END AS avg_watch_time_per_subscriber
FROM subscription_plans p
LEFT JOIN customer_subscriptions cs
    ON cs.plan_id = p.plan_id
   AND cs.is_current = TRUE
LEFT JOIN streaming_sessions s
    ON s.customer_id = cs.customer_id
GROUP BY
    p.plan_name,
    p.monthly_price
ORDER BY
    avg_watch_time_per_subscriber DESC;
