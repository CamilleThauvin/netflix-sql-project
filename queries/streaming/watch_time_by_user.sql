-- Temps de visionnage par utilisateur
SELECT 
    s.customer_id,
    c.customer_name,
    COUNT(*) AS total_sessions,
    SUM(s.session_duration_minutes) AS total_watch_time_minutes,
    ROUND(AVG(s.session_duration_minutes), 1) AS avg_session_duration_minutes
FROM streaming_sessions s
JOIN customers c ON c.customer_id = s.customer_id
GROUP BY s.customer_id, c.customer_name
ORDER BY total_watch_time_minutes DESC;
