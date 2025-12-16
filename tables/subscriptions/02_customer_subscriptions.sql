-- Table des abonnements des clients
-- Chaque ligne représente un client abonné à un plan Netflix à une certaine période
CREATE TABLE IF NOT EXISTS customer_subscriptions (
    customer_subscription_id SERIAL PRIMARY KEY,   -- Identifiant unique de la ligne d'abonnement

    customer_id INT NOT NULL,                     -- Identifiant du client (référence vers la table des clients, à créer plus tard)
    plan_id INT NOT NULL,                         -- Identifiant du plan choisi (référence vers subscription_plans.plan_id)

    start_date DATE NOT NULL,                     -- Date de début de l'abonnement
    end_date DATE,                                -- Date de fin de l'abonnement (NULL si l'abonnement est encore actif)

    is_current BOOLEAN DEFAULT TRUE,              -- TRUE si c'est l'abonnement actuel du client, FALSE sinon

    -- Date et heure de création de la ligne dans la base
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- Clés étrangères (liens logiques vers d'autres tables)
    CONSTRAINT fk_customer_subscriptions_customer
        FOREIGN KEY (customer_id)                 -- customer_id doit exister dans la table des clients
        REFERENCES customers (customer_id),

    CONSTRAINT fk_customer_subscriptions_plan
        FOREIGN KEY (plan_id)                     -- plan_id doit exister dans subscription_plans
        REFERENCES subscription_plans (plan_id)
);
