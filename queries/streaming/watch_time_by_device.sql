SELECT 
    device_type,
    COUNT(*) AS total_sessions,
    SUM(session_duration_minutes) AS total_watch_time_minutes,
    ROUND(AVG(session_duration_minutes), 1) AS avg_session_duration_minutes
FROM streaming_sessions
GROUP BY device_type
ORDER BY total_watch_time_minutes DESC;
