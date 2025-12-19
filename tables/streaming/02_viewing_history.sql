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
