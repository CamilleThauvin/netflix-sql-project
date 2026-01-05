-- Table de progression de visionnage
-- Permet aux utilisateurs de reprendre là où ils se sont arrêtés
CREATE TABLE IF NOT EXISTS watch_progress (
    progress_id SERIAL PRIMARY KEY,                  -- Identifiant unique de la progression

    customer_id INT NOT NULL,                        -- Identifiant du client
    movie_id INT NOT NULL,                           -- Identifiant du film/série

    current_position_seconds INT NOT NULL DEFAULT 0, -- Position actuelle en secondes
    total_duration_seconds INT NOT NULL,             -- Durée totale du contenu en secondes
    percent_completed DECIMAL(5,2) NOT NULL DEFAULT 0.00,  -- Pourcentage complété (0.00 à 100.00)

    last_watched_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,  -- Dernière fois regardé
    is_completed BOOLEAN DEFAULT FALSE,              -- TRUE si le contenu a été regardé jusqu'à la fin

    device_type VARCHAR(20),                         -- Appareil utilisé: 'mobile', 'tv', 'web', 'tablet'

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

-- Insertion de données de test (25+ lignes)
-- Simulation de progressions de visionnage réalistes
INSERT INTO watch_progress (customer_id, movie_id, current_position_seconds, total_duration_seconds, percent_completed, last_watched_at, is_completed, device_type) VALUES
-- Client 1 - plusieurs films en cours
(1, 1, 1800, 3600, 50.00, '2024-08-01 20:30:00', FALSE, 'tv'),           -- Stranger Things S1 - 50%
(1, 2, 5400, 5400, 100.00, '2024-07-28 21:45:00', TRUE, 'tv'),           -- Squid Game - Terminé
(1, 3, 900, 3000, 30.00, '2024-07-25 19:15:00', FALSE, 'mobile'),        -- The Crown - 30%
(1, 5, 4200, 7200, 58.33, '2024-08-02 22:00:00', FALSE, 'web'),          -- La Casa de Papel - 58%

-- Client 2 - utilisateur actif
(2, 1, 3000, 3600, 83.33, '2024-08-01 19:00:00', FALSE, 'mobile'),       -- Stranger Things S1 - 83%
(2, 4, 6000, 6000, 100.00, '2024-07-30 20:00:00', TRUE, 'tv'),           -- Bridgerton - Terminé
(2, 6, 2700, 4500, 60.00, '2024-08-02 18:30:00', FALSE, 'tablet'),       -- Ozark - 60%
(2, 8, 1500, 8100, 18.52, '2024-07-26 21:00:00', FALSE, 'tv'),           -- The Witcher - 18%

-- Client 3 - visionnage familial
(3, 2, 4500, 5400, 83.33, '2024-08-01 20:00:00', FALSE, 'tv'),           -- Squid Game - 83%
(3, 7, 6300, 6300, 100.00, '2024-07-29 22:00:00', TRUE, 'tv'),           -- Dark - Terminé
(3, 9, 3600, 7200, 50.00, '2024-08-02 19:45:00', FALSE, 'tv'),           -- Narcos - 50%

-- Client 4 - utilisateur occasionnel
(4, 3, 600, 3000, 20.00, '2024-07-20 21:30:00', FALSE, 'web'),           -- The Crown - 20%
(4, 5, 7200, 7200, 100.00, '2024-07-15 23:00:00', TRUE, 'web'),          -- La Casa de Papel - Terminé
(4, 10, 1200, 6000, 20.00, '2024-08-01 20:15:00', FALSE, 'mobile'),      -- Élite - 20%

-- Client 5 - binge-watcher
(5, 1, 3600, 3600, 100.00, '2024-07-31 22:00:00', TRUE, 'mobile'),       -- Stranger Things S1 - Terminé
(5, 2, 5400, 5400, 100.00, '2024-08-01 01:30:00', TRUE, 'mobile'),       -- Squid Game - Terminé
(5, 4, 6000, 6000, 100.00, '2024-08-01 23:45:00', TRUE, 'mobile'),       -- Bridgerton - Terminé
(5, 7, 4500, 6300, 71.43, '2024-08-02 20:30:00', FALSE, 'mobile'),       -- Dark - 71%

-- Client 6 - famille avec enfants
(6, 1, 2700, 3600, 75.00, '2024-08-02 19:00:00', FALSE, 'tv'),           -- Stranger Things S1 - 75%
(6, 3, 2100, 3000, 70.00, '2024-07-30 20:30:00', FALSE, 'tv'),           -- The Crown - 70%
(6, 6, 4500, 4500, 100.00, '2024-07-28 21:00:00', TRUE, 'tv'),           -- Ozark - Terminé

-- Client 7 - utilisateur mobile
(7, 2, 2700, 5400, 50.00, '2024-08-01 12:30:00', FALSE, 'mobile'),       -- Squid Game - 50%
(7, 8, 4050, 8100, 50.00, '2024-07-29 13:00:00', FALSE, 'mobile'),       -- The Witcher - 50%
(7, 9, 5400, 7200, 75.00, '2024-08-02 14:15:00', FALSE, 'mobile'),       -- Narcos - 75%

-- Client 8 - cinéphile Premium
(8, 3, 3000, 3000, 100.00, '2024-07-31 21:00:00', TRUE, 'tv'),           -- The Crown - Terminé
(8, 5, 7200, 7200, 100.00, '2024-08-01 22:30:00', TRUE, 'tv'),           -- La Casa de Papel - Terminé
(8, 7, 6300, 6300, 100.00, '2024-08-02 23:00:00', TRUE, 'tv'),           -- Dark - Terminé

-- Client 9 - utilisateur web
(9, 4, 3000, 6000, 50.00, '2024-08-01 19:30:00', FALSE, 'web'),          -- Bridgerton - 50%
(9, 6, 2250, 4500, 50.00, '2024-07-30 20:00:00', FALSE, 'web'),          -- Ozark - 50%

-- Client 10 - nouvel utilisateur
(10, 1, 600, 3600, 16.67, '2024-08-02 18:00:00', FALSE, 'tablet'),       -- Stranger Things S1 - 16%
(10, 2, 1080, 5400, 20.00, '2024-08-01 19:00:00', FALSE, 'tablet');      -- Squid Game - 20%
