-- Table des clients Netflix
-- Chaque ligne représente un client unique de la plateforme
CREATE TABLE IF NOT EXISTS customers (
    customer_id SERIAL PRIMARY KEY,          -- Identifiant unique du client (1, 2, 3, ...)

    first_name VARCHAR(50) NOT NULL,         -- Prénom du client
    last_name  VARCHAR(50) NOT NULL,         -- Nom de famille du client
    email      VARCHAR(100) NOT NULL UNIQUE, -- Adresse email (doit être unique)
    country    VARCHAR(50),                  -- Pays du client (optionnel)

    signup_date DATE NOT NULL,               -- Date d'inscription du client
    is_active   BOOLEAN DEFAULT TRUE,        -- TRUE si le compte est encore actif

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP  -- Date/heure de création de la ligne
);
