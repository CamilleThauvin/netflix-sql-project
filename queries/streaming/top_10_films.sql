-- Top 10 films par temps total de visionnage
SELECT 
    s.movie_id,
    m.title,
    COUNT(*) AS total_sessions,
    SUM(s.session_duration_minutes) AS total_watch_time_minutes,
    ROUND(AVG(s.session_duration_minutes), 1) AS avg_session_duration_minutes
FROM streaming_sessions s
JOIN movies m ON m.movie_id = s.movie_id
GROUP BY s.movie_id, m.title
ORDER BY total_watch_time_minutes DESC
LIMIT 10;
