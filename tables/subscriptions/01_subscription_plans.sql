-- Création de la table des plans d'abonnement Netflix
CREATE TABLE IF NOT EXISTS subscription_plans (
    plan_id SERIAL PRIMARY KEY,              -- Identifiant unique du plan (1, 2, 3, ...)
    plan_name VARCHAR(50) NOT NULL,          -- Nom du plan (Basic, Standard, Premium, etc.)
    monthly_price DECIMAL(10,2) NOT NULL,    -- Prix mensuel de l'abonnement
    max_screens INT NOT NULL,                -- Nombre maximum d'écrans simultanés
    max_quality VARCHAR(20) DEFAULT 'HD',    -- Qualité vidéo max (SD, HD, 4K)
    is_active BOOLEAN DEFAULT TRUE,          -- Plan encore vendu (TRUE) ou ancien plan (FALSE)
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP   -- Date et heure de création de la ligne
);
