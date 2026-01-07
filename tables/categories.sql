-- ==============================================
-- TABLE : CATEGORIES (Genres de films/séries)
-- ==============================================
-- Gère les genres Netflix (Action, Drame, etc.)

CREATE TABLE IF NOT EXISTS categories (
    category_id SERIAL PRIMARY KEY,                  -- ID unique de la catégorie
    category_name VARCHAR(50) NOT NULL UNIQUE        -- Nom (Action, Comédie, etc.)
);

-- Index pour améliorer les recherches par nom
CREATE INDEX IF NOT EXISTS idx_categories_name ON categories(category_name);

-- 20 genres Netflix populaires
INSERT INTO categories (category_name) VALUES
('Action'), ('Comédie'), ('Drame'), ('Thriller'), ('Science-fiction'),
('Horreur'), ('Romance'), ('Animation'), ('Documentaire'), ('Fantastique'),
('Aventure'), ('Policier'), ('Biographie'), ('Historique'), ('Musical'),
('Famille'), ('Guerre'), ('Western'), ('Sport'), ('Mystère')
ON CONFLICT (category_name) DO NOTHING;
