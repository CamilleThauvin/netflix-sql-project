-- Table des paiements
-- Historique de tous les paiements effectués par les clients
CREATE TABLE IF NOT EXISTS payments (
    payment_id SERIAL PRIMARY KEY,                   -- Identifiant unique du paiement

    customer_id INT NOT NULL,                        -- Identifiant du client
    plan_id INT NOT NULL,                            -- Plan payé à ce moment

    amount DECIMAL(10,2) NOT NULL,                   -- Montant payé
    payment_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,  -- Date du paiement
    payment_method VARCHAR(50) NOT NULL,             -- Méthode: 'credit_card', 'paypal', 'bank_transfer', 'mobile_payment'
    payment_status VARCHAR(20) NOT NULL DEFAULT 'completed',    -- Statut: 'completed', 'pending', 'failed', 'refunded'

    transaction_id VARCHAR(100) UNIQUE,              -- ID de transaction externe (processeur de paiement)
    billing_period_start DATE NOT NULL,              -- Début de la période de facturation
    billing_period_end DATE NOT NULL,                -- Fin de la période de facturation

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- Clés étrangères
    CONSTRAINT fk_payments_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers (customer_id),

    CONSTRAINT fk_payments_plan
        FOREIGN KEY (plan_id)
        REFERENCES subscription_plans (plan_id),

    -- Contraintes métier
    CONSTRAINT chk_payment_amount_positive
        CHECK (amount > 0),

    CONSTRAINT chk_payment_method
        CHECK (payment_method IN ('credit_card', 'paypal', 'bank_transfer', 'mobile_payment', 'gift_card')),

    CONSTRAINT chk_payment_status
        CHECK (payment_status IN ('completed', 'pending', 'failed', 'refunded'))
);

-- Index pour recherches fréquentes
CREATE INDEX IF NOT EXISTS idx_payments_customer ON payments(customer_id);
CREATE INDEX IF NOT EXISTS idx_payments_date ON payments(payment_date);
CREATE INDEX IF NOT EXISTS idx_payments_status ON payments(payment_status);

-- Insertion de données de test (30+ lignes)
-- Simulation de paiements mensuels réalistes
INSERT INTO payments (customer_id, plan_id, amount, payment_date, payment_method, payment_status, transaction_id, billing_period_start, billing_period_end) VALUES
-- Janvier 2024
(1, 2, 12.99, '2024-01-15 10:30:00', 'credit_card', 'completed', 'TXN-2024-001', '2024-01-15', '2024-02-14'),
(2, 1, 7.99, '2024-01-20 14:22:00', 'paypal', 'completed', 'TXN-2024-002', '2024-01-20', '2024-02-19'),
(3, 3, 17.99, '2024-02-01 09:15:00', 'credit_card', 'completed', 'TXN-2024-003', '2024-02-01', '2024-03-01'),
(4, 2, 12.99, '2024-02-10 16:45:00', 'bank_transfer', 'completed', 'TXN-2024-004', '2024-02-10', '2024-03-10'),
(5, 1, 7.99, '2024-02-15 11:20:00', 'mobile_payment', 'completed', 'TXN-2024-005', '2024-02-15', '2024-03-15'),

-- Février 2024 (renouvellements)
(1, 2, 12.99, '2024-02-15 10:30:00', 'credit_card', 'completed', 'TXN-2024-006', '2024-02-15', '2024-03-14'),
(2, 1, 7.99, '2024-02-20 14:22:00', 'paypal', 'completed', 'TXN-2024-007', '2024-02-20', '2024-03-19'),
(3, 3, 17.99, '2024-03-01 09:15:00', 'credit_card', 'completed', 'TXN-2024-008', '2024-03-01', '2024-03-31'),
(4, 2, 12.99, '2024-03-10 16:45:00', 'bank_transfer', 'completed', 'TXN-2024-009', '2024-03-10', '2024-04-09'),
(5, 1, 7.99, '2024-03-15 11:20:00', 'mobile_payment', 'completed', 'TXN-2024-010', '2024-03-15', '2024-04-14'),

-- Mars 2024 - avec quelques upgrades
(1, 2, 12.99, '2024-03-15 10:30:00', 'credit_card', 'completed', 'TXN-2024-011', '2024-03-15', '2024-04-14'),
(2, 2, 12.99, '2024-03-20 14:22:00', 'paypal', 'completed', 'TXN-2024-012', '2024-03-20', '2024-04-19'),  -- Upgrade Basic->Standard
(3, 3, 17.99, '2024-03-31 09:15:00', 'credit_card', 'completed', 'TXN-2024-013', '2024-03-31', '2024-04-30'),
(4, 2, 12.99, '2024-04-10 16:45:00', 'bank_transfer', 'completed', 'TXN-2024-014', '2024-04-10', '2024-05-09'),
(5, 2, 12.99, '2024-04-15 11:20:00', 'mobile_payment', 'completed', 'TXN-2024-015', '2024-04-15', '2024-05-14'),  -- Upgrade Basic->Standard

-- Avril 2024
(1, 3, 17.99, '2024-04-15 10:30:00', 'credit_card', 'completed', 'TXN-2024-016', '2024-04-15', '2024-05-14'),  -- Upgrade Standard->Premium
(2, 2, 12.99, '2024-04-20 14:22:00', 'paypal', 'completed', 'TXN-2024-017', '2024-04-20', '2024-05-19'),
(3, 3, 17.99, '2024-04-30 09:15:00', 'credit_card', 'completed', 'TXN-2024-018', '2024-04-30', '2024-05-30'),
(4, 3, 17.99, '2024-05-10 16:45:00', 'bank_transfer', 'completed', 'TXN-2024-019', '2024-05-10', '2024-06-09'),  -- Upgrade Standard->Premium
(5, 2, 12.99, '2024-05-15 11:20:00', 'mobile_payment', 'completed', 'TXN-2024-020', '2024-05-15', '2024-06-14'),

-- Mai 2024 - avec downgrades et échecs
(1, 3, 17.99, '2024-05-15 10:30:00', 'credit_card', 'completed', 'TXN-2024-021', '2024-05-15', '2024-06-14'),
(2, 2, 12.99, '2024-05-20 14:22:00', 'paypal', 'completed', 'TXN-2024-022', '2024-05-20', '2024-06-19'),
(3, 2, 12.99, '2024-05-30 09:15:00', 'credit_card', 'completed', 'TXN-2024-023', '2024-05-30', '2024-06-29'),  -- Downgrade Premium->Standard
(4, 3, 17.99, '2024-06-10 16:45:00', 'bank_transfer', 'failed', 'TXN-2024-024', '2024-06-10', '2024-07-09'),     -- Échec de paiement
(5, 2, 12.99, '2024-06-15 11:20:00', 'mobile_payment', 'completed', 'TXN-2024-025', '2024-06-15', '2024-07-14'),

-- Juin 2024
(1, 2, 12.99, '2024-06-15 10:30:00', 'credit_card', 'completed', 'TXN-2024-026', '2024-06-15', '2024-07-14'),  -- Downgrade Premium->Standard
(2, 1, 7.99, '2024-06-20 14:22:00', 'paypal', 'completed', 'TXN-2024-027', '2024-06-20', '2024-07-19'),       -- Downgrade Standard->Basic
(3, 2, 12.99, '2024-06-29 09:15:00', 'credit_card', 'completed', 'TXN-2024-028', '2024-06-29', '2024-07-29'),
(6, 2, 12.99, '2024-06-01 10:00:00', 'credit_card', 'completed', 'TXN-2024-029', '2024-06-01', '2024-07-01'),
(7, 1, 7.99, '2024-06-10 11:00:00', 'paypal', 'completed', 'TXN-2024-030', '2024-06-10', '2024-07-10'),

-- Juillet 2024
(8, 3, 17.99, '2024-07-01 12:00:00', 'credit_card', 'completed', 'TXN-2024-031', '2024-07-01', '2024-08-01'),
(9, 2, 12.99, '2024-07-15 13:00:00', 'mobile_payment', 'completed', 'TXN-2024-032', '2024-07-15', '2024-08-15'),
(10, 1, 7.99, '2024-07-20 14:00:00', 'bank_transfer', 'completed', 'TXN-2024-033', '2024-07-20', '2024-08-20'),

-- Août 2024 - avec remboursements
(1, 2, 12.99, '2024-07-15 10:30:00', 'credit_card', 'completed', 'TXN-2024-034', '2024-07-15', '2024-08-14'),
(2, 1, 7.99, '2024-07-20 14:22:00', 'paypal', 'refunded', 'TXN-2024-035', '2024-07-20', '2024-08-19'),      -- Remboursement
(3, 2, 12.99, '2024-07-29 09:15:00', 'credit_card', 'completed', 'TXN-2024-036', '2024-07-29', '2024-08-29'),
(6, 3, 17.99, '2024-07-01 10:00:00', 'credit_card', 'completed', 'TXN-2024-037', '2024-07-01', '2024-08-01'),  -- Upgrade
(7, 2, 12.99, '2024-07-10 11:00:00', 'paypal', 'completed', 'TXN-2024-038', '2024-07-10', '2024-08-10');      -- Upgrade
