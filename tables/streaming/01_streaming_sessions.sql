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

-- Table des sessions de visionnage
CREATE TABLE IF NOT EXISTS streaming_sessions (
    session_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    movie_id INT NOT NULL,
    session_start_time TIMESTAMP NOT NULL,
    session_duration_minutes INT,
    device_type VARCHAR(20),  -- 'mobile', 'tv', 'web'
    
    CONSTRAINT fk_sessions_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_sessions_movie FOREIGN KEY (movie_id) REFERENCES movies(movie_id)
);

