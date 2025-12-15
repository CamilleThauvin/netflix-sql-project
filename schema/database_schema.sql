-- Création de la base Netflix
CREATE DATABASE netflix_production;

-- Connexion à la base
\c netflix_production;

-- Tables de référence (pays, catégories)
CREATE TABLE countries (
    country_id SERIAL PRIMARY KEY,
    country_name VARCHAR(50) NOT NULL
);

CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

