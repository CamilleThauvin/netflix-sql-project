INSERT INTO subscription_plans (plan_name, monthly_price, max_screens, max_quality, is_active)
VALUES
    ('Basic',     7.99, 1, 'HD',  TRUE),
    ('Standard', 12.99, 2, 'HD',  TRUE),
    ('Premium',  17.99, 4, '4K',  TRUE),
    ('Mobile',    5.99, 1, 'SD',  TRUE),
    ('Family',   19.99, 5, '4K',  TRUE);
-- Insertion de données de test dans la table subscription_plans
-- Chaque ligne représente un type d'abonnement Netflix

INSERT INTO subscription_plans (plan_name, monthly_price, max_screens, max_quality, is_active)
VALUES
    -- Plan d'entrée de gamme, pas cher, un seul écran en HD
    ('Basic',     7.99, 1, 'HD',  TRUE),

    -- Plan standard, deux écrans en HD
    ('Standard', 12.99, 2, 'HD',  TRUE),

    -- Plan premium, quatre écrans en 4K
    ('Premium',  17.99, 4, '4K',  TRUE),

    -- Plan mobile, très bon marché, qualité SD, un seul écran
    ('Mobile',    5.99, 1, 'SD',  TRUE),

    -- Plan famille, plus d'écrans, meilleure qualité
    ('Family',   19.99, 5, '4K',  TRUE);
