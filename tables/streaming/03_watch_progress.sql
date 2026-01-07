-- ==============================================
-- TABLE : WATCH_PROGRESS (Progression de visionnage)
-- ==============================================
-- Permet aux utilisateurs de reprendre là où ils se sont arrêtés

CREATE TABLE IF NOT EXISTS watch_progress (
    progress_id SERIAL PRIMARY KEY,

    customer_id INT NOT NULL,
    movie_id INT NOT NULL,

    current_position_seconds INT NOT NULL DEFAULT 0,
    total_duration_seconds INT NOT NULL,
    percent_completed DECIMAL(5,2) NOT NULL DEFAULT 0.00,

    last_watched_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    is_completed BOOLEAN DEFAULT FALSE,

    device_type VARCHAR(20),

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- Clés étrangères
    CONSTRAINT fk_watch_progress_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers (customer_id),

    CONSTRAINT fk_watch_progress_movie
        FOREIGN KEY (movie_id)
        REFERENCES movies (movie_id),

    -- Contraintes métier
    CONSTRAINT chk_position_positive
        CHECK (current_position_seconds >= 0),

    CONSTRAINT chk_position_not_exceed_duration
        CHECK (current_position_seconds <= total_duration_seconds),

    CONSTRAINT chk_percent_range
        CHECK (percent_completed >= 0.00 AND percent_completed <= 100.00),

    CONSTRAINT chk_device_type
        CHECK (device_type IN ('mobile', 'tv', 'web', 'tablet')),

    -- Un client ne peut avoir qu'une seule progression active par film
    CONSTRAINT uq_customer_movie_progress
        UNIQUE (customer_id, movie_id)
);

-- Index pour recherches fréquentes
CREATE INDEX IF NOT EXISTS idx_watch_progress_customer ON watch_progress(customer_id);
CREATE INDEX IF NOT EXISTS idx_watch_progress_last_watched ON watch_progress(last_watched_at);
CREATE INDEX IF NOT EXISTS idx_watch_progress_incomplete ON watch_progress(is_completed) WHERE is_completed = FALSE;
