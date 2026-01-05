-- Table des téléchargements offline
-- Gestion des contenus téléchargés pour visionnage hors ligne
CREATE TABLE IF NOT EXISTS downloads (
    download_id SERIAL PRIMARY KEY,                  -- Identifiant unique du téléchargement

    customer_id INT NOT NULL,                        -- Identifiant du client
    movie_id INT NOT NULL,                           -- Identifiant du film/série téléchargé
    plan_id INT NOT NULL,                            -- Plan actif au moment du téléchargement

    download_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,  -- Date du téléchargement
    expiration_date TIMESTAMP NOT NULL,              -- Date d'expiration (généralement +30 jours)

    download_quality VARCHAR(20) NOT NULL,           -- Qualité: 'SD', 'HD', '4K'
    file_size_mb INT NOT NULL,                       -- Taille du fichier en Mo
    device_type VARCHAR(20) NOT NULL,                -- Appareil: 'mobile', 'tablet'

    status VARCHAR(20) NOT NULL DEFAULT 'active',    -- Statut: 'active', 'expired', 'deleted', 'watched'
    is_watched BOOLEAN DEFAULT FALSE,                -- TRUE si le contenu téléchargé a été regardé

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- Clés étrangères
    CONSTRAINT fk_downloads_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers (customer_id),

    CONSTRAINT fk_downloads_movie
        FOREIGN KEY (movie_id)
        REFERENCES movies (movie_id),

    CONSTRAINT fk_downloads_plan
        FOREIGN KEY (plan_id)
        REFERENCES subscription_plans (plan_id),

    -- Contraintes métier
    CONSTRAINT chk_download_quality
        CHECK (download_quality IN ('SD', 'HD', '4K')),

    CONSTRAINT chk_download_device
        CHECK (device_type IN ('mobile', 'tablet')),

    CONSTRAINT chk_download_status
        CHECK (status IN ('active', 'expired', 'deleted', 'watched')),

    CONSTRAINT chk_file_size_positive
        CHECK (file_size_mb > 0),

    CONSTRAINT chk_expiration_after_download
        CHECK (expiration_date > download_date)
);

-- Index pour recherches fréquentes
CREATE INDEX IF NOT EXISTS idx_downloads_customer ON downloads(customer_id);
CREATE INDEX IF NOT EXISTS idx_downloads_status ON downloads(status);
CREATE INDEX IF NOT EXISTS idx_downloads_expiration ON downloads(expiration_date);
CREATE INDEX IF NOT EXISTS idx_downloads_device ON downloads(device_type);

-- Insertion de données de test (30+ lignes)
-- Simulation de téléchargements réalistes avec différents statuts
INSERT INTO downloads (customer_id, movie_id, plan_id, download_date, expiration_date, download_quality, file_size_mb, device_type, status, is_watched) VALUES
-- Client 1 - Utilisateur Premium avec tablet et mobile
(1, 1, 3, '2024-07-15 08:30:00', '2024-08-14 08:30:00', '4K', 3500, 'tablet', 'watched', TRUE),
(1, 2, 3, '2024-07-20 10:00:00', '2024-08-19 10:00:00', '4K', 4200, 'tablet', 'active', FALSE),
(1, 5, 3, '2024-07-25 14:30:00', '2024-08-24 14:30:00', 'HD', 2800, 'mobile', 'active', FALSE),
(1, 7, 3, '2024-06-10 09:00:00', '2024-07-10 09:00:00', '4K', 3800, 'tablet', 'expired', FALSE),

-- Client 2 - Utilisateur Standard avec mobile
(2, 1, 2, '2024-07-18 07:45:00', '2024-08-17 07:45:00', 'HD', 2200, 'mobile', 'watched', TRUE),
(2, 3, 2, '2024-07-22 11:30:00', '2024-08-21 11:30:00', 'HD', 1800, 'mobile', 'active', FALSE),
(2, 6, 2, '2024-07-28 16:00:00', '2024-08-27 16:00:00', 'HD', 2500, 'mobile', 'active', FALSE),
(2, 8, 2, '2024-06-15 12:00:00', '2024-07-15 12:00:00', 'HD', 4000, 'mobile', 'expired', FALSE),

-- Client 3 - Famille Premium
(3, 2, 3, '2024-07-20 19:00:00', '2024-08-19 19:00:00', '4K', 4200, 'tablet', 'watched', TRUE),
(3, 4, 3, '2024-07-25 20:30:00', '2024-08-24 20:30:00', '4K', 3600, 'tablet', 'active', FALSE),
(3, 7, 3, '2024-07-30 15:45:00', '2024-08-29 15:45:00', 'HD', 3200, 'mobile', 'active', FALSE),
(3, 9, 3, '2024-08-01 10:15:00', '2024-08-31 10:15:00', '4K', 4500, 'tablet', 'active', FALSE),

-- Client 4 - Utilisateur Standard occasionnel
(4, 3, 2, '2024-07-10 08:00:00', '2024-08-09 08:00:00', 'HD', 1800, 'mobile', 'active', FALSE),
(4, 5, 2, '2024-06-20 14:00:00', '2024-07-20 14:00:00', 'HD', 2800, 'tablet', 'expired', TRUE),
(4, 10, 2, '2024-07-28 09:30:00', '2024-08-27 09:30:00', 'SD', 1200, 'mobile', 'active', FALSE),

-- Client 5 - Binge-watcher mobile (Basic)
(5, 1, 1, '2024-07-22 06:30:00', '2024-08-21 06:30:00', 'SD', 1500, 'mobile', 'watched', TRUE),
(5, 2, 1, '2024-07-23 07:00:00', '2024-08-22 07:00:00', 'SD', 1800, 'mobile', 'watched', TRUE),
(5, 4, 1, '2024-07-25 08:00:00', '2024-08-24 08:00:00', 'SD', 1600, 'mobile', 'active', FALSE),

-- Client 6 - Famille Standard
(6, 1, 2, '2024-07-26 18:00:00', '2024-08-25 18:00:00', 'HD', 2200, 'tablet', 'active', FALSE),
(6, 3, 2, '2024-07-28 19:30:00', '2024-08-27 19:30:00', 'HD', 1800, 'tablet', 'active', FALSE),
(6, 6, 2, '2024-07-18 17:00:00', '2024-08-17 17:00:00', 'HD', 2500, 'mobile', 'watched', TRUE),

-- Client 7 - Utilisateur mobile Basic
(7, 2, 1, '2024-07-20 12:00:00', '2024-08-19 12:00:00', 'SD', 1800, 'mobile', 'active', FALSE),
(7, 8, 1, '2024-07-24 13:30:00', '2024-08-23 13:30:00', 'SD', 2400, 'mobile', 'active', FALSE),
(7, 9, 1, '2024-06-25 11:00:00', '2024-07-25 11:00:00', 'SD', 2100, 'mobile', 'expired', FALSE),

-- Client 8 - Cinéphile Premium
(8, 3, 3, '2024-07-29 21:00:00', '2024-08-28 21:00:00', '4K', 2400, 'tablet', 'watched', TRUE),
(8, 5, 3, '2024-07-30 22:00:00', '2024-08-29 22:00:00', '4K', 3500, 'tablet', 'active', FALSE),
(8, 7, 3, '2024-07-31 20:30:00', '2024-08-30 20:30:00', '4K', 3800, 'tablet', 'watched', TRUE),
(8, 10, 3, '2024-08-01 19:00:00', '2024-08-31 19:00:00', '4K', 3600, 'tablet', 'active', FALSE),

-- Client 9 - Utilisateur Standard web/mobile
(9, 4, 2, '2024-07-27 10:30:00', '2024-08-26 10:30:00', 'HD', 3600, 'tablet', 'active', FALSE),
(9, 6, 2, '2024-07-29 11:00:00', '2024-08-28 11:00:00', 'HD', 2500, 'mobile', 'active', FALSE),

-- Client 10 - Nouvel utilisateur Basic
(10, 1, 1, '2024-08-01 08:00:00', '2024-08-31 08:00:00', 'SD', 1500, 'mobile', 'active', FALSE),
(10, 2, 1, '2024-08-02 09:00:00', '2024-09-01 09:00:00', 'SD', 1800, 'mobile', 'active', FALSE),

-- Téléchargements supplémentaires - téléchargements puis suppression manuelle
(1, 9, 3, '2024-07-12 15:00:00', '2024-08-11 15:00:00', '4K', 4500, 'tablet', 'deleted', FALSE),
(3, 1, 3, '2024-07-05 10:00:00', '2024-08-04 10:00:00', '4K', 3500, 'tablet', 'deleted', FALSE);
