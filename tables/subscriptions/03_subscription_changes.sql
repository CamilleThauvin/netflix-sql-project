-- Table des changements d'abonnements
-- Historique de tous les upgrades, downgrades et annulations
CREATE TABLE IF NOT EXISTS subscription_changes (
    change_id SERIAL PRIMARY KEY,                    -- Identifiant unique du changement

    customer_id INT NOT NULL,                        -- Identifiant du client
    old_plan_id INT,                                 -- Ancien plan (NULL si première souscription)
    new_plan_id INT,                                 -- Nouveau plan (NULL si annulation)

    change_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,  -- Date du changement
    change_type VARCHAR(20) NOT NULL,                -- Type: 'upgrade', 'downgrade', 'new', 'cancel', 'reactivation'
    change_reason VARCHAR(100),                      -- Raison du changement (optionnel)

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- Clés étrangères
    CONSTRAINT fk_subscription_changes_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers (customer_id),

    CONSTRAINT fk_subscription_changes_old_plan
        FOREIGN KEY (old_plan_id)
        REFERENCES subscription_plans (plan_id),

    CONSTRAINT fk_subscription_changes_new_plan
        FOREIGN KEY (new_plan_id)
        REFERENCES subscription_plans (plan_id),

    -- Contraintes métier
    CONSTRAINT chk_change_type
        CHECK (change_type IN ('upgrade', 'downgrade', 'new', 'cancel', 'reactivation'))
);

-- Index pour recherches fréquentes
CREATE INDEX IF NOT EXISTS idx_subscription_changes_customer ON subscription_changes(customer_id);
CREATE INDEX IF NOT EXISTS idx_subscription_changes_date ON subscription_changes(change_date);

-- Insertion de données de test (20+ lignes)
-- Simulation d'évolutions d'abonnements réalistes
INSERT INTO subscription_changes (customer_id, old_plan_id, new_plan_id, change_date, change_type, change_reason) VALUES
-- Nouvelles souscriptions (change_type = 'new')
(1, NULL, 2, '2024-01-15 10:30:00', 'new', 'Première inscription'),
(2, NULL, 1, '2024-01-20 14:22:00', 'new', 'Première inscription'),
(3, NULL, 3, '2024-02-01 09:15:00', 'new', 'Première inscription'),
(4, NULL, 2, '2024-02-10 16:45:00', 'new', 'Première inscription'),
(5, NULL, 1, '2024-02-15 11:20:00', 'new', 'Première inscription'),

-- Upgrades (Basic -> Standard, Standard -> Premium)
(2, 1, 2, '2024-03-15 10:00:00', 'upgrade', 'Besoin de plus d''écrans'),
(5, 1, 2, '2024-03-20 14:30:00', 'upgrade', 'Meilleure qualité vidéo souhaitée'),
(1, 2, 3, '2024-04-01 09:00:00', 'upgrade', 'Passage à 4K'),
(4, 2, 3, '2024-04-15 16:00:00', 'upgrade', 'Famille nombreuse'),

-- Downgrades (Premium -> Standard, Standard -> Basic)
(3, 3, 2, '2024-05-01 10:15:00', 'downgrade', 'Réduction des coûts'),
(1, 3, 2, '2024-05-20 11:30:00', 'downgrade', 'Budget serré'),
(2, 2, 1, '2024-06-01 14:00:00', 'downgrade', 'Utilisation moins fréquente'),

-- Annulations (change_type = 'cancel')
(5, 2, NULL, '2024-06-15 09:45:00', 'cancel', 'Vacances d''été'),
(3, 2, NULL, '2024-07-01 10:00:00', 'cancel', 'Trop cher'),

-- Réactivations (change_type = 'reactivation')
(5, NULL, 1, '2024-08-01 12:00:00', 'reactivation', 'Retour des vacances'),
(3, NULL, 2, '2024-08-15 15:30:00', 'reactivation', 'Nouvelle série à regarder'),

-- Autres mouvements
(6, NULL, 2, '2024-03-01 10:00:00', 'new', 'Première inscription'),
(7, NULL, 1, '2024-03-10 11:00:00', 'new', 'Première inscription'),
(8, NULL, 3, '2024-04-01 12:00:00', 'new', 'Première inscription'),
(9, NULL, 2, '2024-04-15 13:00:00', 'new', 'Première inscription'),
(10, NULL, 1, '2024-05-01 14:00:00', 'new', 'Première inscription'),

(6, 2, 3, '2024-06-01 10:30:00', 'upgrade', 'Upgrade vers Premium'),
(7, 1, 2, '2024-06-15 11:30:00', 'upgrade', 'Plus d''écrans nécessaires'),
(10, 1, 2, '2024-07-01 12:30:00', 'upgrade', 'Meilleure qualité'),
(8, 3, 2, '2024-07-15 13:30:00', 'downgrade', 'Économies'),
(9, 2, 1, '2024-08-01 14:30:00', 'downgrade', 'Budget réduit');
