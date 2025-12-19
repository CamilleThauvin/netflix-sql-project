-- Migration 002 : Création table movies
-- Date : 2025-12-18

-- Créer la table (code ci-dessus)
-- [Coller le CREATE TABLE movies ici]

-- Ajouter 50 films/séries de test
INSERT INTO movies (title, release_year, duration_minutes, categorie_id, country_id, rating, is_original) VALUES
('Stranger Things', 2016, NULL, 1, 1, 8.7, TRUE),   -- 1=Action (à adapter)
('Squid Game', 2021, NULL, 1, 16, 8.0, TRUE),       -- 16=Corée du Sud
('The Crown', 2016, NULL, 3, 5, 8.6, TRUE),          -- 3=Drame, 5=UK
('Narcos', 2015, NULL, 4, 7, 8.8, TRUE),             -- 4=Thriller, 7=Mexique
('Money Heist', 2017, NULL, 4, 1, 8.2, FALSE),       -- France
('Dark', 2017, NULL, 5, 2, 8.7, TRUE),               -- 5=SciFi, 2=Allemagne
('Bridgerton', 2020, NULL, 7, 5, 7.4, TRUE),         -- 7=Romance
('The Witcher', 2019, NULL, 1, 1, 7.9, TRUE),
('Ozark', 2017, NULL, 4, 6, 8.5, TRUE),              -- 6=USA
('Lupin', 2021, NULL, 4, 1, 7.5, TRUE);
