-- ==============================================
-- TABLE : PAYMENTS (Paiements)
-- ==============================================
-- Historique de tous les paiements effectués par les clients

CREATE TABLE IF NOT EXISTS payments (
    payment_id SERIAL PRIMARY KEY,

    customer_id INT NOT NULL,
    plan_id INT NOT NULL,

    amount DECIMAL(10,2) NOT NULL,
    payment_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(50) NOT NULL,
    payment_status VARCHAR(20) NOT NULL DEFAULT 'completed',

    transaction_id VARCHAR(100) UNIQUE,
    billing_period_start DATE NOT NULL,
    billing_period_end DATE NOT NULL,

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
