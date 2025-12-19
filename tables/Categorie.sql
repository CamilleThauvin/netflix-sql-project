-- Table des catégories (genres Netflix)
CREATE TABLE IF NOT EXISTS categorie (
    categorie_id SERIAL PRIMARY KEY,      -- ID unique de la catégorie
    category_name VARCHAR(50) NOT NULL UNIQUE  -- Nom (Action, Comédie, etc.)
);

-- 20 genres Netflix populaires
INSERT INTO categorie (category_name) VALUES
('Action'), ('Comédie'), ('Drame'), ('Thriller'), ('Science-fiction'),
('Horreur'), ('Romance'), ('Animation'), ('Documentaire'), ('Fantastique'),
('Aventure'), ('Policier'), ('Biographie'), ('Historique'), ('Musical'),
('Famille'), ('Guerre'), ('Western'), ('Sport'), ('Mystère')
ON CONFLICT (category_name) DO NOTHING;
