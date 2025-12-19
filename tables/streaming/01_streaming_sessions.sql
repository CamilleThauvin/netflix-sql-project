-- 01_streaming_sessions.sql
-- Nombre de sessions de visionnage par film / client

-- Top 10 films les plus lancés
SELECT 
    m.title,
    COUNT(*) as nb_sessions,
    ROUND(AVG(ss.session_duration_minutes), 1) as duree_moyenne_minutes
FROM streaming_sessions ss
JOIN movies m ON ss.movie_id = m.movie_id
GROUP BY m.movie_id, m.title
ORDER BY nb_sessions DESC
LIMIT 10;

-- Sessions par jour
SELECT 
    DATE_TRUNC('day', session_start_time) as jour,
    COUNT(*) as nb_sessions
FROM streaming_sessions
GROUP BY jour
ORDER BY jour DESC
LIMIT 7;
