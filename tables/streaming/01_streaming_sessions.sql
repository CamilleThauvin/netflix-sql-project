-- ==============================================
-- TABLE : STREAMING_SESSIONS (Sessions de visionnage)
-- ==============================================
-- Enregistre chaque session de visionnage d'un client

CREATE TABLE IF NOT EXISTS streaming_sessions (
    session_id SERIAL PRIMARY KEY,                   -- ID unique de la session
    customer_id INT NOT NULL,                        -- ID du client
    movie_id INT NOT NULL,                           -- ID du film/série regardé
    session_start_time TIMESTAMP NOT NULL,           -- Heure de début de la session
    session_duration_minutes INT,                    -- Durée de visionnage en minutes
    device_type VARCHAR(20),                         -- Type d'appareil: 'mobile', 'tv', 'web', 'tablet'

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- Clés étrangères
    CONSTRAINT fk_sessions_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    CONSTRAINT fk_sessions_movie
        FOREIGN KEY (movie_id)
        REFERENCES movies(movie_id),

    -- Contraintes métier
    CONSTRAINT chk_device_type
        CHECK (device_type IN ('mobile', 'tv', 'web', 'tablet')),

    CONSTRAINT chk_duration_positive
        CHECK (session_duration_minutes >= 0)
);

-- Index pour améliorer les performances
CREATE INDEX IF NOT EXISTS idx_streaming_sessions_customer ON streaming_sessions(customer_id);
CREATE INDEX IF NOT EXISTS idx_streaming_sessions_movie ON streaming_sessions(movie_id);
CREATE INDEX IF NOT EXISTS idx_streaming_sessions_start_time ON streaming_sessions(session_start_time);
CREATE INDEX IF NOT EXISTS idx_streaming_sessions_device ON streaming_sessions(device_type);
