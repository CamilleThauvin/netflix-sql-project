-- ==============================================
-- TABLE : COUNTRIES (Pays)
-- ==============================================
-- Référentiel géographique des pays Netflix

CREATE TABLE IF NOT EXISTS countries (
    country_id SERIAL PRIMARY KEY,                   -- ID unique du pays
    country_name VARCHAR(50) NOT NULL UNIQUE         -- Nom du pays
);

-- Index pour améliorer les recherches par nom
CREATE INDEX IF NOT EXISTS idx_countries_name ON countries(country_name);

-- 20 principaux marchés Netflix dans le monde
INSERT INTO countries (country_name) VALUES
('France'), ('Allemagne'), ('Espagne'), ('Italie'),
('Royaume-Uni'), ('États-Unis'), ('Canada'), ('Belgique'),
('Pays-Bas'), ('Suisse'), ('Brésil'), ('Mexique'),
('Inde'), ('Japon'), ('Australie'), ('Corée du Sud'),
('Pologne'), ('Suède'), ('Norvège'), ('Danemark')
ON CONFLICT (country_name) DO NOTHING;
