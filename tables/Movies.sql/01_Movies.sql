-- Table des films/séries Netflix
CREATE TABLE IF NOT EXISTS movies (
    movie_id SERIAL PRIMARY KEY,              -- ID unique du film/série
    
    title VARCHAR(255) NOT NULL,              -- Titre (ex: "Stranger Things")
    release_year INT NOT NULL,                -- Année de sortie
    duration_minutes INT,                     -- Durée en minutes (NULL pour séries)
    
    categorie_id INT,                         -- Référence catégorie (Action, etc.)
    country_id INT,                           -- Pays d'origine
    
    rating DECIMAL(3,2),                      -- Note /10 (ex: 8.45)
    is_original BOOLEAN DEFAULT FALSE,        -- Netflix Original ?
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Clés étrangères
    CONSTRAINT fk_movies_categorie 
        FOREIGN KEY (categorie_id) REFERENCES categorie(categorie_id),
    CONSTRAINT fk_movies_country 
        FOREIGN KEY (country_id) REFERENCES countries(country_id)
);

-- Table des catégories (genres Netflix)
CREATE TABLE IF NOT EXISTS categorie (
    categorie_id SERIAL PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL UNIQUE
);

INSERT INTO categorie (category_name) VALUES
('Action'), ('Comédie'), ('Drame'), ('Thriller'), ('Science-fiction'),
('Horreur'), ('Romance'), ('Animation'), ('Documentaire'), ('Fantastique'),
('Aventure'), ('Policier'), ('Biographie'), ('Historique'), ('Musical'),
('Famille'), ('Guerre'), ('Western'), ('Sport'), ('Mystère')
ON CONFLICT (category_name) DO NOTHING;
