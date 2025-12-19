SELECT
    DATE(session_start_time) AS watch_date,
    COUNT(*) AS total_sessions,
    SUM(session_duration_minutes) AS total_watch_time_minutes,
    ROUND(AVG(session_duration_minutes), 1) AS avg_session_duration_minutes
FROM streaming_sessions
GROUP BY DATE(session_start_time)
ORDER BY watch_date;
