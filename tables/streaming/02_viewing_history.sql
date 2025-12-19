-- 02_viewing_history.sql
-- Historique de visionnage clients

-- Films vus par client (top 5)
SELECT 
    c.first_name || ' ' || c.last_name as client,
    m.title,
    vh.watch_date,
    vh.percent_watched
FROM viewing_history vh
JOIN customers c ON vh.customer_id = c.customer_id
JOIN movies m ON vh.movie_id = m.movie_id
ORDER BY vh.watch_date DESC
LIMIT 10;

-- Clients les plus actifs (nb films vus)
SELECT 
    c.customer_id,
    c.first_name || ' ' || c.last_name as client,
    COUNT(DISTINCT vh.movie_id) as nb_films_vus
FROM viewing_history vh
JOIN customers c ON vh.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY nb_films_vus DESC
LIMIT 10;


-- Historique de visionnage
CREATE TABLE IF NOT EXISTS viewing_history (
    history_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    movie_id INT NOT NULL,
    watch_date DATE NOT NULL,
    percent_watched DECIMAL(5,2),  -- 75.50%
    episodes_watched INT DEFAULT 1,
    
    CONSTRAINT fk_history_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_history_movie FOREIGN KEY (movie_id) REFERENCES movies(movie_id)
);
