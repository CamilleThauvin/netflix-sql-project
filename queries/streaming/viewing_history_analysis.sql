-- Analyses de l'historique de visionnage

-- 1) Films récemment visionnés (top 10)
SELECT
    c.first_name || ' ' || c.last_name AS client,
    m.title,
    vh.watch_date,
    vh.percent_watched,
    vh.episodes_watched
FROM viewing_history vh
JOIN customers c ON vh.customer_id = c.customer_id
JOIN movies m ON vh.movie_id = m.movie_id
ORDER BY vh.watch_date DESC
LIMIT 10;

-- 2) Clients les plus actifs (nombre de films vus)
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS client,
    COUNT(DISTINCT vh.movie_id) AS nb_films_vus,
    ROUND(AVG(vh.percent_watched), 1) AS avg_completion_pct
FROM viewing_history vh
JOIN customers c ON vh.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY nb_films_vus DESC
LIMIT 10;
