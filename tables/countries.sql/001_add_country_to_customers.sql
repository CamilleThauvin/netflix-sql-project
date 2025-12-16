-- Table des pays (référentiel géographique)
CREATE TABLE IF NOT EXISTS countries (
    country_id SERIAL PRIMARY KEY,    -- ID unique du pays
    country_name VARCHAR(50) NOT NULL UNIQUE  -- Nom du pays
);

-- Données de test (20 principaux marchés Netflix)
INSERT INTO countries (country_name) VALUES
('France'), ('Allemagne'), ('Espagne'), ('Italie'), ('Royaume-Uni'),
('États-Unis'), ('Canada'), ('Belgique'), ('Pays-Bas'), ('Suisse'),
('Brésil'), ('Mexique'), ('Inde'), ('Japon'), ('Australie'),
('Corée du Sud'), ('Pologne'), ('Suède'), ('Norvège'), ('Danemark')
ON CONFLICT (country_name) DO NOTHING;


-- Table des catégories (genres Netflix)
CREATE TABLE IF NOT EXISTS categorie (
    categorie_id SERIAL PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL
);

-- 25 genres Netflix
INSERT INTO categorie (category_name) VALUES
('Action'), ('Comédie'), ('Drame'), ('Thriller'), ('Science-fiction'),
('Horreur'), ('Romance'), ('Animation'), ('Documentaire'), ('Fantastique')
ON CONFLICT DO NOTHING;


-- Table des pays (référentiel géographique Netflix)
CREATE TABLE IF NOT EXISTS countries (
    country_id SERIAL PRIMARY KEY,        -- ID unique du pays
    country_name VARCHAR(50) NOT NULL UNIQUE  -- Nom du pays
);

-- 20 principaux marchés Netflix
INSERT INTO countries (country_name) VALUES
('France'), ('Allemagne'), ('Espagne'), ('Italie'), 
('Royaume-Uni'), ('États-Unis'), ('Canada'), ('Belgique'), 
('Pays-Bas'), ('Suisse'), ('Brésil'), ('Mexique'), 
('Inde'), ('Japon'), ('Australie'), ('Corée du Sud'), 
('Pologne'), ('Suède'), ('Norvège'), ('Danemark')
ON CONFLICT (country_name) DO NOTHING;
