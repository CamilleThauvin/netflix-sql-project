-- ==============================================
-- TABLE : MOVIES (Films et Séries Netflix)
-- ==============================================
-- Gère le catalogue de films et séries disponibles

CREATE TABLE IF NOT EXISTS movies (
    movie_id SERIAL PRIMARY KEY,              -- ID unique du film/série

    title VARCHAR(255) NOT NULL,              -- Titre (ex: "Stranger Things")
    release_year INT NOT NULL,                -- Année de sortie
    duration_minutes INT,                     -- Durée en minutes (NULL pour séries)

    category_id INT,                          -- Référence catégorie (Action, etc.)
    country_id INT,                           -- Pays d'origine

    rating DECIMAL(3,2),                      -- Note /10 (ex: 8.45)
    is_original BOOLEAN DEFAULT FALSE,        -- Netflix Original ?

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- Clés étrangères
    CONSTRAINT fk_movies_category
        FOREIGN KEY (category_id) REFERENCES categories(category_id),
    CONSTRAINT fk_movies_country
        FOREIGN KEY (country_id) REFERENCES countries(country_id)
);

-- Index pour améliorer les performances
CREATE INDEX IF NOT EXISTS idx_movies_category ON movies(category_id);
CREATE INDEX IF NOT EXISTS idx_movies_country ON movies(country_id);
CREATE INDEX IF NOT EXISTS idx_movies_release_year ON movies(release_year);
CREATE INDEX IF NOT EXISTS idx_movies_is_original ON movies(is_original);
