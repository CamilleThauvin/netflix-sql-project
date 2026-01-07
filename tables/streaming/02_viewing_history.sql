-- ==============================================
-- TABLE : VIEWING_HISTORY (Historique de visionnage)
-- ==============================================
-- Historique complet des films/séries visionnés par les clients

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
