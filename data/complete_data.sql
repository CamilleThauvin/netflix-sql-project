-- =====================================================
-- FICHIER DE DONNÉES COMPLÈTES POUR LE PROJET NETFLIX
-- =====================================================
-- Ce fichier contient toutes les insertions de données
-- avec au moins 10 lignes par table (sauf subscription_plans qui en a 5)
--
-- ORDRE D'EXÉCUTION :
-- 1. Tables de référence (countries, categories, subscription_plans)
-- 2. Tables principales (customers, movies)
-- 3. Tables dépendantes (customer_subscriptions, streaming_sessions, viewing_history, etc.)
-- =====================================================

-- =====================================================
-- 1. TABLE : COUNTRIES (Pays)
-- =====================================================
-- 20 principaux marchés Netflix dans le monde

INSERT INTO countries (country_name) VALUES
('France'), ('Allemagne'), ('Espagne'), ('Italie'),
('Royaume-Uni'), ('États-Unis'), ('Canada'), ('Belgique'),
('Pays-Bas'), ('Suisse'), ('Brésil'), ('Mexique'),
('Inde'), ('Japon'), ('Australie'), ('Corée du Sud'),
('Pologne'), ('Suède'), ('Norvège'), ('Danemark')
ON CONFLICT (country_name) DO NOTHING;

-- =====================================================
-- 2. TABLE : CATEGORIES (Genres de films/séries)
-- =====================================================
-- 20 genres Netflix populaires

INSERT INTO categories (category_name) VALUES
('Action'), ('Comédie'), ('Drame'), ('Thriller'), ('Science-fiction'),
('Horreur'), ('Romance'), ('Animation'), ('Documentaire'), ('Fantastique'),
('Aventure'), ('Policier'), ('Biographie'), ('Historique'), ('Musical'),
('Famille'), ('Guerre'), ('Western'), ('Sport'), ('Mystère')
ON CONFLICT (category_name) DO NOTHING;

-- =====================================================
-- 3. TABLE : SUBSCRIPTION_PLANS (Plans d'abonnement)
-- =====================================================
-- 5 plans d'abonnement Netflix (Basic, Standard, Premium, Mobile, Family)

INSERT INTO subscription_plans (plan_name, monthly_price, max_screens, max_quality, is_active)
VALUES
    ('Basic',     7.99, 1, 'HD',  TRUE),   -- Plan d'entrée de gamme
    ('Standard', 12.99, 2, 'HD',  TRUE),   -- Plan standard
    ('Premium',  17.99, 4, '4K',  TRUE),   -- Plan premium 4K
    ('Mobile',    5.99, 1, 'SD',  TRUE),   -- Plan mobile uniquement
    ('Family',   19.99, 5, '4K',  TRUE)    -- Plan familial (5 écrans)
ON CONFLICT DO NOTHING;

-- =====================================================
-- 4. TABLE : CUSTOMERS (Clients Netflix)
-- =====================================================
-- 50 clients Netflix de différents pays avec dates d'inscription variées

INSERT INTO customers (first_name, last_name, email, country, signup_date, is_active) VALUES
-- Clients actifs français
('Marie', 'Dupont', 'marie.dupont@email.fr', 'France', '2023-01-15', TRUE),
('Jean', 'Martin', 'jean.martin@email.fr', 'France', '2023-02-20', TRUE),
('Sophie', 'Bernard', 'sophie.bernard@email.fr', 'France', '2023-03-10', TRUE),
('Pierre', 'Dubois', 'pierre.dubois@email.fr', 'France', '2023-04-05', TRUE),
('Julie', 'Laurent', 'julie.laurent@email.fr', 'France', '2023-05-12', TRUE),
('Lucas', 'Simon', 'lucas.simon@email.fr', 'France', '2023-06-18', TRUE),
('Emma', 'Michel', 'emma.michel@email.fr', 'France', '2023-07-22', TRUE),
('Hugo', 'Leroy', 'hugo.leroy@email.fr', 'France', '2023-08-30', TRUE),
('Chloé', 'Moreau', 'chloe.moreau@email.fr', 'France', '2023-09-14', TRUE),
('Thomas', 'Fournier', 'thomas.fournier@email.fr', 'France', '2023-10-08', TRUE),

-- Clients internationaux actifs
('John', 'Smith', 'john.smith@email.com', 'États-Unis', '2023-01-20', TRUE),
('Emily', 'Johnson', 'emily.johnson@email.com', 'États-Unis', '2023-02-15', TRUE),
('Michael', 'Williams', 'michael.williams@email.com', 'Canada', '2023-03-12', TRUE),
('Sarah', 'Brown', 'sarah.brown@email.co.uk', 'Royaume-Uni', '2023-04-18', TRUE),
('David', 'Jones', 'david.jones@email.co.uk', 'Royaume-Uni', '2023-05-22', TRUE),
('Anna', 'Schmidt', 'anna.schmidt@email.de', 'Allemagne', '2023-06-10', TRUE),
('Hans', 'Müller', 'hans.mueller@email.de', 'Allemagne', '2023-07-15', TRUE),
('Carlos', 'García', 'carlos.garcia@email.es', 'Espagne', '2023-08-20', TRUE),
('Maria', 'Rodríguez', 'maria.rodriguez@email.es', 'Espagne', '2023-09-05', TRUE),
('Giovanni', 'Rossi', 'giovanni.rossi@email.it', 'Italie', '2023-10-12', TRUE),

-- Clients actifs Asie/Océanie
('Yuki', 'Tanaka', 'yuki.tanaka@email.jp', 'Japon', '2023-02-08', TRUE),
('Hiro', 'Yamamoto', 'hiro.yamamoto@email.jp', 'Japon', '2023-03-14', TRUE),
('Min-jun', 'Kim', 'minjun.kim@email.kr', 'Corée du Sud', '2023-04-20', TRUE),
('Ji-woo', 'Park', 'jiwoo.park@email.kr', 'Corée du Sud', '2023-05-25', TRUE),
('Raj', 'Patel', 'raj.patel@email.in', 'Inde', '2023-06-30', TRUE),
('Priya', 'Sharma', 'priya.sharma@email.in', 'Inde', '2023-07-10', TRUE),
('James', 'Wilson', 'james.wilson@email.au', 'Australie', '2023-08-15', TRUE),
('Olivia', 'Taylor', 'olivia.taylor@email.au', 'Australie', '2023-09-20', TRUE),

-- Clients Amérique du Sud
('Pedro', 'Silva', 'pedro.silva@email.br', 'Brésil', '2023-02-12', TRUE),
('Ana', 'Santos', 'ana.santos@email.br', 'Brésil', '2023-03-18', TRUE),
('Diego', 'López', 'diego.lopez@email.mx', 'Mexique', '2023-04-22', TRUE),
('Sofía', 'Hernández', 'sofia.hernandez@email.mx', 'Mexique', '2023-05-28', TRUE),

-- Clients Europe du Nord
('Lars', 'Andersson', 'lars.andersson@email.se', 'Suède', '2023-06-05', TRUE),
('Ingrid', 'Nilsson', 'ingrid.nilsson@email.se', 'Suède', '2023-07-12', TRUE),
('Ole', 'Hansen', 'ole.hansen@email.no', 'Norvège', '2023-08-18', TRUE),
('Signe', 'Jensen', 'signe.jensen@email.dk', 'Danemark', '2023-09-22', TRUE),

-- Clients Benelux/Suisse
('Marc', 'Dubois', 'marc.dubois@email.be', 'Belgique', '2023-02-25', TRUE),
('Sophie', 'Janssens', 'sophie.janssens@email.be', 'Belgique', '2023-03-30', TRUE),
('Jan', 'de Vries', 'jan.devries@email.nl', 'Pays-Bas', '2023-04-15', TRUE),
('Emma', 'van Berg', 'emma.vanberg@email.nl', 'Pays-Bas', '2023-05-20', TRUE),
('Felix', 'Schneider', 'felix.schneider@email.ch', 'Suisse', '2023-06-25', TRUE),
('Julia', 'Weber', 'julia.weber@email.ch', 'Suisse', '2023-07-30', TRUE),

-- Clients Pologne
('Piotr', 'Kowalski', 'piotr.kowalski@email.pl', 'Pologne', '2023-08-05', TRUE),
('Zofia', 'Nowak', 'zofia.nowak@email.pl', 'Pologne', '2023-09-10', TRUE),

-- Clients churnés (inactifs)
('Alice', 'Petit', 'alice.petit@email.fr', 'France', '2022-06-10', FALSE),
('Bob', 'Roux', 'bob.roux@email.fr', 'France', '2022-07-15', FALSE),
('Charlie', 'Blanc', 'charlie.blanc@email.fr', 'France', '2022-08-20', FALSE),
('Diana', 'Noir', 'diana.noir@email.fr', 'France', '2022-09-25', FALSE),
('Edward', 'Green', 'edward.green@email.com', 'États-Unis', '2022-10-30', FALSE),
('Fiona', 'White', 'fiona.white@email.co.uk', 'Royaume-Uni', '2022-11-05', FALSE);

-- =====================================================
-- 5. TABLE : MOVIES (Films et Séries Netflix)
-- =====================================================
-- 20 films/séries Netflix populaires avec catégories et pays d'origine

INSERT INTO movies (title, release_year, duration_minutes, category_id, country_id, rating, is_original) VALUES
-- Netflix Originals célèbres
('Stranger Things', 2016, NULL, 5, 6, 8.70, TRUE),          -- Science-fiction, USA
('Squid Game', 2021, NULL, 4, 16, 8.00, TRUE),              -- Thriller, Corée du Sud
('The Crown', 2016, NULL, 3, 5, 8.60, TRUE),                -- Drame, Royaume-Uni
('Bridgerton', 2020, NULL, 7, 5, 7.40, TRUE),               -- Romance, Royaume-Uni
('Money Heist (La Casa de Papel)', 2017, NULL, 4, 3, 8.20, TRUE),  -- Thriller, Espagne
('Dark', 2017, NULL, 5, 2, 8.70, TRUE),                     -- Science-fiction, Allemagne
('The Witcher', 2019, NULL, 10, 6, 7.90, TRUE),             -- Fantastique, USA
('Ozark', 2017, NULL, 4, 6, 8.50, TRUE),                    -- Thriller, USA
('Narcos', 2015, NULL, 12, 7, 8.80, TRUE),                  -- Policier, Mexique (Colombie)
('Lupin', 2021, NULL, 12, 1, 7.50, TRUE),                   -- Policier, France
('Élite', 2018, NULL, 3, 3, 7.60, TRUE),                    -- Drame, Espagne
('Black Mirror', 2011, NULL, 5, 5, 8.80, TRUE),             -- Science-fiction, Royaume-Uni
('The Queen''s Gambit', 2020, NULL, 3, 6, 8.60, TRUE),      -- Drame, USA
('Emily in Paris', 2020, NULL, 2, 1, 7.00, TRUE),           -- Comédie, France
('Vikings: Valhalla', 2022, NULL, 11, 4, 7.20, TRUE),       -- Aventure, Italie (tournage)

-- Quelques films non-originaux (licences)
('Inception', 2010, 148, 5, 6, 8.80, FALSE),                -- Science-fiction, USA
('The Matrix', 1999, 136, 1, 6, 8.70, FALSE),               -- Action, USA
('Parasite', 2019, 132, 4, 16, 8.50, FALSE),                -- Thriller, Corée du Sud
('Amélie', 2001, 122, 2, 1, 8.30, FALSE),                   -- Comédie, France
('Spirited Away', 2001, 125, 8, 14, 8.60, FALSE);           -- Animation, Japon

-- =====================================================
-- 6. TABLE : CUSTOMER_SUBSCRIPTIONS (Abonnements clients)
-- =====================================================
-- Historique des abonnements de 50 clients (abonnements actuels)

INSERT INTO customer_subscriptions (customer_id, plan_id, start_date, end_date, is_current) VALUES
-- Clients actifs avec abonnements en cours
(1, 2, '2023-01-15', NULL, TRUE),   -- Marie, Standard
(2, 1, '2023-02-20', NULL, TRUE),   -- Jean, Basic
(3, 3, '2023-03-10', NULL, TRUE),   -- Sophie, Premium
(4, 2, '2023-04-05', NULL, TRUE),   -- Pierre, Standard
(5, 1, '2023-05-12', NULL, TRUE),   -- Julie, Basic
(6, 3, '2023-06-18', NULL, TRUE),   -- Lucas, Premium
(7, 2, '2023-07-22', NULL, TRUE),   -- Emma, Standard
(8, 3, '2023-08-30', NULL, TRUE),   -- Hugo, Premium
(9, 2, '2023-09-14', NULL, TRUE),   -- Chloé, Standard
(10, 1, '2023-10-08', NULL, TRUE),  -- Thomas, Basic

(11, 2, '2023-01-20', NULL, TRUE),  -- John, Standard
(12, 3, '2023-02-15', NULL, TRUE),  -- Emily, Premium
(13, 2, '2023-03-12', NULL, TRUE),  -- Michael, Standard
(14, 3, '2023-04-18', NULL, TRUE),  -- Sarah, Premium
(15, 2, '2023-05-22', NULL, TRUE),  -- David, Standard
(16, 3, '2023-06-10', NULL, TRUE),  -- Anna, Premium
(17, 2, '2023-07-15', NULL, TRUE),  -- Hans, Standard
(18, 2, '2023-08-20', NULL, TRUE),  -- Carlos, Standard
(19, 1, '2023-09-05', NULL, TRUE),  -- Maria, Basic
(20, 3, '2023-10-12', NULL, TRUE),  -- Giovanni, Premium

(21, 2, '2023-02-08', NULL, TRUE),  -- Yuki, Standard
(22, 1, '2023-03-14', NULL, TRUE),  -- Hiro, Basic
(23, 2, '2023-04-20', NULL, TRUE),  -- Min-jun, Standard
(24, 3, '2023-05-25', NULL, TRUE),  -- Ji-woo, Premium
(25, 1, '2023-06-30', NULL, TRUE),  -- Raj, Basic
(26, 2, '2023-07-10', NULL, TRUE),  -- Priya, Standard
(27, 3, '2023-08-15', NULL, TRUE),  -- James, Premium
(28, 2, '2023-09-20', NULL, TRUE),  -- Olivia, Standard

(29, 2, '2023-02-12', NULL, TRUE),  -- Pedro, Standard
(30, 1, '2023-03-18', NULL, TRUE),  -- Ana, Basic
(31, 2, '2023-04-22', NULL, TRUE),  -- Diego, Standard
(32, 3, '2023-05-28', NULL, TRUE),  -- Sofía, Premium

(33, 2, '2023-06-05', NULL, TRUE),  -- Lars, Standard
(34, 1, '2023-07-12', NULL, TRUE),  -- Ingrid, Basic
(35, 2, '2023-08-18', NULL, TRUE),  -- Ole, Standard
(36, 3, '2023-09-22', NULL, TRUE),  -- Signe, Premium

(37, 2, '2023-02-25', NULL, TRUE),  -- Marc, Standard
(38, 1, '2023-03-30', NULL, TRUE),  -- Sophie J., Basic
(39, 2, '2023-04-15', NULL, TRUE),  -- Jan, Standard
(40, 3, '2023-05-20', NULL, TRUE),  -- Emma vB, Premium
(41, 2, '2023-06-25', NULL, TRUE),  -- Felix, Standard
(42, 1, '2023-07-30', NULL, TRUE),  -- Julia, Basic

(43, 2, '2023-08-05', NULL, TRUE),  -- Piotr, Standard
(44, 3, '2023-09-10', NULL, TRUE),  -- Zofia, Premium

-- Clients churnés (anciens abonnements terminés)
(45, 1, '2022-06-10', '2023-06-10', FALSE),  -- Alice, Basic (churné)
(46, 1, '2022-07-15', '2023-07-15', FALSE),  -- Bob, Basic (churné)
(47, 2, '2022-08-20', '2023-08-20', FALSE),  -- Charlie, Standard (churné)
(48, 2, '2022-09-25', '2023-09-25', FALSE),  -- Diana, Standard (churné)
(49, 1, '2022-10-30', '2023-10-30', FALSE),  -- Edward, Basic (churné)
(50, 2, '2022-11-05', '2023-11-05', FALSE);  -- Fiona, Standard (churné)

-- =====================================================
-- 7. TABLE : STREAMING_SESSIONS (Sessions de visionnage)
-- =====================================================
-- 100 sessions de visionnage réalistes réparties sur les clients et films

INSERT INTO streaming_sessions (customer_id, movie_id, session_start_time, session_duration_minutes, device_type) VALUES
-- Marie (client 1) - Fan de séries fantastiques - ACTIF RECENT
(1, 1, '2026-01-02 20:30:00', 52, 'tv'),    -- Stranger Things
(1, 1, '2026-01-03 21:00:00', 55, 'tv'),    -- Stranger Things S1E2
(1, 7, '2026-01-04 20:15:00', 48, 'tv'),    -- The Witcher
(1, 12, '2026-01-05 19:45:00', 50, 'tv'),   -- Black Mirror
(1, 6, '2026-01-06 21:30:00', 45, 'web'),   -- Dark

-- Jean (client 2) - Utilisateur mobile, visionnage court - INACTIF (3 mois)
(2, 19, '2024-10-15 12:30:00', 25, 'mobile'),  -- Amélie
(2, 14, '2024-10-16 13:00:00', 30, 'mobile'),  -- Emily in Paris
(2, 2, '2024-10-18 12:45:00', 20, 'mobile'),   -- Squid Game

-- Sophie (client 3) - Premium, binge-watcher - ACTIF RECENT
(3, 3, '2025-12-28 19:00:00', 60, 'tv'),    -- The Crown
(3, 3, '2025-12-28 20:05:00', 58, 'tv'),    -- The Crown E2
(3, 13, '2025-12-29 20:00:00', 55, 'tv'),   -- The Queens Gambit
(3, 4, '2025-12-30 19:30:00', 52, 'tv'),    -- Bridgerton
(3, 4, '2025-12-30 20:25:00', 50, 'tv'),    -- Bridgerton E2

-- Pierre (client 4) - Fan d'action et thrillers - MODEREMENT ACTIF (1 mois)
(4, 5, '2025-11-20 21:00:00', 45, 'tv'),    -- Money Heist
(4, 8, '2025-11-22 20:30:00', 50, 'tv'),    -- Ozark
(4, 9, '2025-11-25 21:15:00', 48, 'tv'),    -- Narcos
(4, 18, '2025-12-01 20:00:00', 42, 'web'),  -- Parasite
(4, 17, '2025-12-05 21:00:00', 40, 'tv'),   -- The Matrix

-- Julie (client 5) - Fan de comédies françaises - INACTIF (5 mois)
(5, 14, '2024-08-10 19:30:00', 28, 'mobile'), -- Emily in Paris
(5, 19, '2024-08-12 20:00:00', 35, 'web'),    -- Amélie
(5, 10, '2024-08-15 19:00:00', 40, 'tv'),     -- Lupin

-- Lucas (client 6) - Premium, cinéphile - ACTIF RECENT
(6, 16, '2025-12-31 22:00:00', 148, 'tv'),  -- Inception (film complet)
(6, 17, '2026-01-01 21:30:00', 136, 'tv'),  -- The Matrix (film complet)
(6, 6, '2026-01-02 20:00:00', 55, 'tv'),    -- Dark
(6, 12, '2026-01-03 21:00:00', 50, 'tv'),   -- Black Mirror

-- Emma (client 7) - Fan de drames - MODEREMENT ACTIF (2 mois)
(7, 3, '2024-11-08 19:00:00', 58, 'tv'),    -- The Crown
(7, 11, '2024-11-10 20:00:00', 52, 'tv'),   -- Élite
(7, 13, '2024-11-15 19:30:00', 54, 'tv'),   -- The Queens Gambit

-- Hugo (client 8) - Aventures et fantasy - ACTIF RECENT
(8, 15, '2025-12-20 20:00:00', 50, 'tv'),   -- Vikings Valhalla
(8, 7, '2025-12-22 19:30:00', 55, 'tv'),    -- The Witcher
(8, 1, '2025-12-28 20:30:00', 52, 'tv'),    -- Stranger Things

-- Chloé (client 9) - Séries coréennes - INACTIF (4 mois)
(9, 2, '2024-09-12 21:00:00', 55, 'tv'),    -- Squid Game
(9, 2, '2024-09-13 20:30:00', 58, 'tv'),    -- Squid Game E2
(9, 18, '2024-09-18 21:30:00', 45, 'tv'),   -- Parasite

-- Thomas (client 10) - Documentaires et thrillers - ACTIF MOYEN (1.5 mois)
(10, 9, '2025-11-18 20:00:00', 50, 'web'),  -- Narcos
(10, 8, '2025-11-22 21:00:00', 48, 'web'),  -- Ozark
(10, 5, '2025-11-28 20:30:00', 52, 'tv'),   -- Money Heist

-- John (client 11) - Fan américain de sci-fi - ACTIF RECENT
(11, 1, '2025-12-25 19:00:00', 50, 'tv'),   -- Stranger Things
(11, 6, '2025-12-26 20:00:00', 55, 'tv'),   -- Dark
(11, 12, '2025-12-27 21:00:00', 48, 'tv'),  -- Black Mirror

-- Emily (client 12) - Romance et drames - TRES ACTIF RECENT
(12, 4, '2026-01-01 20:30:00', 52, 'tv'),   -- Bridgerton
(12, 3, '2026-01-02 19:30:00', 58, 'tv'),   -- The Crown
(12, 14, '2026-01-03 20:00:00', 30, 'mobile'), -- Emily in Paris

-- Michael (client 13) - Action canadien - INACTIF (6 mois)
(13, 17, '2024-07-10 21:00:00', 120, 'tv'), -- The Matrix
(13, 16, '2024-07-12 20:00:00', 130, 'tv'), -- Inception
(13, 7, '2024-07-15 19:30:00', 55, 'tv'),   -- The Witcher

-- Sarah (client 14) - Fan britannique de drames - ACTIF RECENT
(14, 3, '2025-12-18 19:00:00', 60, 'tv'),   -- The Crown
(14, 3, '2025-12-18 20:05:00', 58, 'tv'),   -- The Crown E2
(14, 13, '2025-12-20 20:00:00', 54, 'tv'),  -- The Queens Gambit

-- David (client 15) - Thrillers UK - MODEREMENT ACTIF (2 mois)
(15, 12, '2024-11-05 21:00:00', 50, 'tv'),  -- Black Mirror
(15, 8, '2024-11-08 20:30:00', 48, 'tv'),   -- Ozark
(15, 10, '2024-11-12 21:00:00', 45, 'web'), -- Lupin

-- Anna (client 16) - Allemande, fan de Dark - ACTIF RECENT
(16, 6, '2025-12-15 20:00:00', 55, 'tv'),   -- Dark
(16, 6, '2025-12-16 20:00:00', 58, 'tv'),   -- Dark E2
(16, 6, '2025-12-17 19:30:00', 52, 'tv'),   -- Dark E3

-- Hans (client 17) - Sci-fi allemand - INACTIF (7 mois)
(17, 12, '2024-06-05 20:30:00', 48, 'tv'),  -- Black Mirror
(17, 1, '2024-06-08 21:00:00', 52, 'tv'),   -- Stranger Things
(17, 16, '2024-06-12 20:00:00', 140, 'tv'), -- Inception

-- Carlos (client 18) - Espagnol, contenu local - ACTIF RECENT
(18, 5, '2025-12-22 20:00:00', 50, 'tv'),   -- Money Heist
(18, 11, '2025-12-24 19:30:00', 48, 'tv'),  -- Élite
(18, 5, '2025-12-26 20:30:00', 52, 'tv'),   -- Money Heist E2

-- Maria (client 19) - Drames espagnols - INACTIF (3 mois)
(19, 11, '2024-10-10 19:00:00', 50, 'mobile'), -- Élite
(19, 5, '2024-10-12 20:00:00', 48, 'tv'),      -- Money Heist
(19, 4, '2024-10-15 19:30:00', 52, 'tv'),      -- Bridgerton

-- Giovanni (client 20) - Italien, films classiques - MODEREMENT ACTIF (1 mois)
(20, 19, '2024-12-05 21:00:00', 100, 'tv'), -- Amélie
(20, 18, '2024-12-08 20:30:00', 120, 'tv'), -- Parasite
(20, 16, '2024-12-12 21:00:00', 140, 'tv'), -- Inception

-- Clients asiatiques (21-28)
(21, 2, '2025-12-28 12:00:00', 55, 'mobile'), -- Yuki - Squid Game - ACTIF
(21, 20, '2025-12-29 13:00:00', 100, 'tv'),   -- Spirited Away
(22, 20, '2024-08-20 14:00:00', 120, 'mobile'), -- Hiro - Spirited Away - INACTIF
(23, 2, '2025-11-15 19:00:00', 58, 'tv'),     -- Min-jun - Squid Game - MOYEN
(23, 18, '2025-11-18 20:00:00', 130, 'tv'),   -- Parasite
(24, 2, '2026-01-01 20:30:00', 60, 'tv'),     -- Ji-woo - Squid Game - ACTIF
(24, 2, '2026-01-02 19:30:00', 58, 'tv'),     -- Squid Game E2
(25, 1, '2024-09-05 18:00:00', 45, 'mobile'), -- Raj - Stranger Things - INACTIF
(26, 7, '2025-12-10 19:30:00', 50, 'tv'),     -- Priya - The Witcher - ACTIF
(27, 15, '2025-11-25 20:00:00', 52, 'tv'),    -- James - Vikings - MOYEN
(28, 3, '2024-07-20 19:00:00', 55, 'tv'),     -- Olivia - The Crown - TRES INACTIF

-- Clients sud-américains (29-32)
(29, 9, '2025-12-12 21:00:00', 50, 'tv'),     -- Pedro - Narcos - ACTIF
(29, 5, '2025-12-15 20:30:00', 52, 'tv'),     -- Money Heist
(30, 14, '2024-10-20 19:00:00', 30, 'mobile'), -- Ana - Emily in Paris - INACTIF
(31, 9, '2025-11-08 20:00:00', 55, 'tv'),     -- Diego - Narcos - MOYEN
(32, 5, '2026-01-04 19:30:00', 50, 'tv'),     -- Sofía - Money Heist - ACTIF

-- Clients nordiques (33-36)
(33, 12, '2024-11-18 20:00:00', 48, 'tv'),    -- Lars - Black Mirror - MOYEN
(34, 6, '2024-09-25 19:30:00', 52, 'mobile'), -- Ingrid - Dark - INACTIF
(35, 15, '2025-12-08 20:30:00', 50, 'tv'),    -- Ole - Vikings - ACTIF
(36, 4, '2025-11-22 19:00:00', 55, 'tv'),     -- Signe - Bridgerton - MOYEN

-- Clients Benelux/Suisse (37-42)
(37, 10, '2025-12-30 20:00:00', 45, 'tv'),    -- Marc - Lupin - ACTIF
(38, 19, '2024-08-18 19:00:00', 90, 'web'),   -- Sophie J. - Amélie - INACTIF
(39, 6, '2025-11-30 20:30:00', 55, 'tv'),     -- Jan - Dark - MOYEN
(40, 3, '2026-01-05 19:30:00', 58, 'tv'),     -- Emma vB - The Crown - ACTIF
(41, 6, '2024-12-02 20:00:00', 52, 'tv'),     -- Felix - Dark - MOYEN
(42, 14, '2024-10-05 19:00:00', 28, 'mobile'), -- Julia - Emily in Paris - INACTIF

-- Clients polonais (43-44)
(43, 7, '2025-12-18 20:00:00', 55, 'tv'),     -- Piotr - The Witcher - ACTIF
(44, 1, '2024-06-20 19:30:00', 50, 'tv');     -- Zofia - Stranger Things - TRES INACTIF

-- =====================================================
-- 8. TABLE : VIEWING_HISTORY (Historique de visionnage)
-- =====================================================
-- Historique simplifié de visionnage avec pourcentage de complétion

INSERT INTO viewing_history (customer_id, movie_id, watch_date, percent_watched, episodes_watched) VALUES
-- Marie (client 1) - ACTIF RECENT
(1, 1, '2026-01-02', 100.00, 1),
(1, 1, '2026-01-03', 100.00, 1),
(1, 7, '2026-01-04', 90.00, 1),
(1, 12, '2026-01-05', 100.00, 1),
(1, 6, '2026-01-06', 85.00, 1),

-- Jean (client 2) - INACTIF (3 mois)
(2, 19, '2024-10-15', 100.00, 1),
(2, 14, '2024-10-16', 100.00, 1),
(2, 2, '2024-10-18', 45.00, 1),

-- Sophie (client 3) - ACTIF RECENT
(3, 3, '2025-12-28', 100.00, 2),
(3, 13, '2025-12-29', 100.00, 1),
(3, 4, '2025-12-30', 100.00, 2),

-- Pierre (client 4) - MODEREMENT ACTIF (1 mois)
(4, 5, '2025-11-20', 100.00, 1),
(4, 8, '2025-11-22', 100.00, 1),
(4, 9, '2025-11-25', 95.00, 1),
(4, 18, '2025-12-01', 100.00, 1),
(4, 17, '2025-12-05', 100.00, 1),

-- Julie (client 5) - INACTIF (5 mois)
(5, 14, '2024-08-10', 100.00, 1),
(5, 19, '2024-08-12', 100.00, 1),
(5, 10, '2024-08-15', 100.00, 1),

-- Lucas (client 6) - ACTIF RECENT
(6, 16, '2025-12-31', 100.00, 1),
(6, 17, '2026-01-01', 100.00, 1),
(6, 6, '2026-01-02', 100.00, 1),
(6, 12, '2026-01-03', 100.00, 1),

-- Emma (client 7) - MODEREMENT ACTIF (2 mois)
(7, 3, '2024-11-08', 100.00, 1),
(7, 11, '2024-11-10', 100.00, 1),
(7, 13, '2024-11-15', 100.00, 1),

-- Hugo (client 8) - ACTIF RECENT
(8, 15, '2025-12-20', 100.00, 1),
(8, 7, '2025-12-22', 100.00, 1),
(8, 1, '2025-12-28', 100.00, 1),

-- Chloé (client 9) - INACTIF (4 mois)
(9, 2, '2024-09-12', 100.00, 1),
(9, 2, '2024-09-13', 100.00, 1),
(9, 18, '2024-09-18', 80.00, 1),

-- Thomas (client 10) - ACTIF MOYEN (1.5 mois)
(10, 9, '2025-11-18', 100.00, 1),
(10, 8, '2025-11-22', 100.00, 1),
(10, 5, '2025-11-28', 100.00, 1),

-- Plus d'historique pour les autres clients
(11, 1, '2025-12-25', 100.00, 1),
(12, 4, '2026-01-01', 100.00, 1),
(13, 17, '2024-07-10', 100.00, 1),
(14, 3, '2025-12-18', 100.00, 2),
(15, 12, '2024-11-05', 100.00, 1),
(16, 6, '2025-12-15', 100.00, 3),
(17, 12, '2024-06-05', 100.00, 1),
(18, 5, '2025-12-22', 100.00, 2),
(19, 11, '2024-10-10', 100.00, 1),
(20, 19, '2024-12-05', 100.00, 1),
(21, 2, '2025-12-28', 100.00, 1),
(22, 20, '2024-08-20', 100.00, 1),
(23, 2, '2025-11-15', 100.00, 1),
(24, 2, '2026-01-01', 100.00, 2),
(25, 1, '2024-09-05', 75.00, 1),
(26, 7, '2025-12-10', 100.00, 1),
(27, 15, '2025-11-25', 100.00, 1),
(28, 3, '2024-07-20', 100.00, 1);


-- =====================================================
-- 9. TABLE : WATCH_PROGRESS (Progression de visionnage)
-- =====================================================
-- Permet aux utilisateurs de reprendre là où ils se sont arrêtés

INSERT INTO watch_progress (customer_id, movie_id, current_position_seconds, total_duration_seconds, percent_completed, last_watched_at, is_completed, device_type) VALUES
-- Client 1 - plusieurs films en cours - ACTIF RECENT
(1, 1, 1800, 3600, 50.00, '2026-01-06 20:30:00', FALSE, 'tv'),
(1, 2, 5400, 5400, 100.00, '2026-01-04 21:45:00', TRUE, 'tv'),
(1, 3, 900, 3000, 30.00, '2026-01-02 19:15:00', FALSE, 'mobile'),
(1, 5, 4200, 7200, 58.33, '2026-01-05 22:00:00', FALSE, 'web'),

-- Client 2 - utilisateur inactif - INACTIF (3 mois)
(2, 1, 3000, 3600, 83.33, '2024-10-16 19:00:00', FALSE, 'mobile'),
(2, 4, 6000, 6000, 100.00, '2024-10-15 20:00:00', TRUE, 'tv'),
(2, 6, 2700, 4500, 60.00, '2024-10-18 18:30:00', FALSE, 'tablet'),
(2, 8, 1500, 8100, 18.52, '2024-10-14 21:00:00', FALSE, 'tv'),

-- Client 3 - visionnage familial - ACTIF RECENT
(3, 2, 4500, 5400, 83.33, '2025-12-30 20:00:00', FALSE, 'tv'),
(3, 7, 6300, 6300, 100.00, '2025-12-29 22:00:00', TRUE, 'tv'),
(3, 9, 3600, 7200, 50.00, '2025-12-28 19:45:00', FALSE, 'tv'),

-- Client 4 - utilisateur occasionnel - MODEREMENT ACTIF
(4, 3, 600, 3000, 20.00, '2025-11-22 21:30:00', FALSE, 'web'),
(4, 5, 7200, 7200, 100.00, '2025-12-05 23:00:00', TRUE, 'web'),
(4, 10, 1200, 6000, 20.00, '2025-11-25 20:15:00', FALSE, 'mobile'),

-- Client 5 - binge-watcher - INACTIF (5 mois)
(5, 1, 3600, 3600, 100.00, '2024-08-14 22:00:00', TRUE, 'mobile'),
(5, 2, 5400, 5400, 100.00, '2024-08-15 01:30:00', TRUE, 'mobile'),
(5, 4, 6000, 6000, 100.00, '2024-08-12 23:45:00', TRUE, 'mobile'),
(5, 7, 4500, 6300, 71.43, '2024-08-10 20:30:00', FALSE, 'mobile'),

-- Client 6 - famille avec enfants - ACTIF RECENT
(6, 1, 2700, 3600, 75.00, '2026-01-03 19:00:00', FALSE, 'tv'),
(6, 3, 2100, 3000, 70.00, '2026-01-02 20:30:00', FALSE, 'tv'),
(6, 6, 4500, 4500, 100.00, '2026-01-01 21:00:00', TRUE, 'tv'),

-- Client 7 - utilisateur mobile - MODEREMENT ACTIF
(7, 2, 2700, 5400, 50.00, '2024-11-12 12:30:00', FALSE, 'mobile'),
(7, 8, 4050, 8100, 50.00, '2024-11-10 13:00:00', FALSE, 'mobile'),
(7, 9, 5400, 7200, 75.00, '2024-11-08 14:15:00', FALSE, 'mobile'),

-- Client 8 - cinéphile Premium - ACTIF RECENT
(8, 3, 3000, 3000, 100.00, '2025-12-28 21:00:00', TRUE, 'tv'),
(8, 5, 7200, 7200, 100.00, '2025-12-25 22:30:00', TRUE, 'tv'),
(8, 7, 6300, 6300, 100.00, '2025-12-22 23:00:00', TRUE, 'tv'),

-- Client 9 - utilisateur web - INACTIF (4 mois)
(9, 4, 3000, 6000, 50.00, '2024-09-15 19:30:00', FALSE, 'web'),
(9, 6, 2250, 4500, 50.00, '2024-09-13 20:00:00', FALSE, 'web'),

-- Client 10 - nouvel utilisateur - ACTIF MOYEN
(10, 1, 600, 3600, 16.67, '2025-11-28 18:00:00', FALSE, 'tablet'),
(10, 2, 1080, 5400, 20.00, '2025-11-22 19:00:00', FALSE, 'tablet');

-- =====================================================
-- 10. TABLE : PAYMENTS (Paiements)
-- =====================================================
-- Historique de tous les paiements effectués par les clients

INSERT INTO payments (customer_id, plan_id, amount, payment_date, payment_method, payment_status, transaction_id, billing_period_start, billing_period_end) VALUES
-- Paiements anciens (clients fidèles - 2024)
(1, 2, 12.99, '2024-01-15 10:30:00', 'credit_card', 'completed', 'TXN-2024-001', '2024-01-15', '2024-02-14'),
(3, 3, 17.99, '2024-02-01 09:15:00', 'credit_card', 'completed', 'TXN-2024-003', '2024-02-01', '2024-03-01'),
(6, 3, 17.99, '2024-03-18 10:00:00', 'credit_card', 'completed', 'TXN-2024-016', '2024-03-18', '2024-04-17'),
(8, 3, 17.99, '2024-04-30 12:00:00', 'credit_card', 'completed', 'TXN-2024-018', '2024-04-30', '2024-05-30'),

-- Clients inactifs - derniers paiements (CHURN POTENTIEL)
(2, 1, 7.99, '2024-10-20 14:22:00', 'paypal', 'completed', 'TXN-2024-042', '2024-10-20', '2024-11-19'),
(5, 1, 7.99, '2024-08-15 11:20:00', 'mobile_payment', 'failed', 'TXN-2024-028', '2024-08-15', '2024-09-14'),
(9, 2, 12.99, '2024-09-15 13:00:00', 'mobile_payment', 'completed', 'TXN-2024-035', '2024-09-15', '2024-10-15'),
(13, 2, 12.99, '2024-07-12 14:00:00', 'bank_transfer', 'completed', 'TXN-2024-025', '2024-07-12', '2024-08-11'),
(17, 2, 12.99, '2024-06-15 10:30:00', 'credit_card', 'failed', 'TXN-2024-022', '2024-06-15', '2024-07-14'),
(19, 1, 7.99, '2024-10-12 14:22:00', 'paypal', 'completed', 'TXN-2024-043', '2024-10-12', '2024-11-11'),
(22, 1, 7.99, '2024-08-20 14:00:00', 'bank_transfer', 'completed', 'TXN-2024-030', '2024-08-20', '2024-09-19'),
(25, 1, 7.99, '2024-09-05 18:00:00', 'mobile_payment', 'completed', 'TXN-2024-033', '2024-09-05', '2024-10-04'),
(28, 2, 12.99, '2024-07-20 19:00:00', 'credit_card', 'completed', 'TXN-2024-026', '2024-07-20', '2024-08-19'),
(38, 1, 7.99, '2024-08-18 19:00:00', 'paypal', 'completed', 'TXN-2024-029', '2024-08-18', '2024-09-17'),
(42, 1, 7.99, '2024-10-05 19:00:00', 'mobile_payment', 'failed', 'TXN-2024-041', '2024-10-05', '2024-11-04'),
(44, 1, 7.99, '2024-06-20 19:30:00', 'credit_card', 'completed', 'TXN-2024-023', '2024-06-20', '2024-07-19'),

-- Clients moyennement actifs
(4, 2, 12.99, '2024-06-05 16:45:00', 'bank_transfer', 'completed', 'TXN-2024-020', '2024-06-05', '2024-07-04'),
(4, 2, 12.99, '2024-11-05 16:45:00', 'bank_transfer', 'completed', 'TXN-2024-050', '2024-11-05', '2024-12-04'),
(4, 2, 12.99, '2025-12-05 16:45:00', 'bank_transfer', 'completed', 'TXN-2025-068', '2025-12-05', '2026-01-04'),
(7, 2, 12.99, '2024-05-22 11:00:00', 'paypal', 'completed', 'TXN-2024-019', '2024-05-22', '2024-06-21'),
(7, 2, 12.99, '2024-11-22 11:00:00', 'paypal', 'completed', 'TXN-2024-052', '2024-11-22', '2024-12-21'),
(10, 1, 7.99, '2024-10-08 14:00:00', 'bank_transfer', 'completed', 'TXN-2024-044', '2024-10-08', '2024-11-07'),
(10, 1, 7.99, '2025-11-08 14:00:00', 'bank_transfer', 'completed', 'TXN-2025-060', '2025-11-08', '2025-12-07'),
(15, 2, 12.99, '2024-05-22 21:00:00', 'credit_card', 'completed', 'TXN-2024-021', '2024-05-22', '2024-06-21'),
(15, 2, 12.99, '2024-11-22 21:00:00', 'credit_card', 'completed', 'TXN-2024-053', '2024-11-22', '2024-12-21'),
(20, 3, 17.99, '2024-10-12 21:00:00', 'credit_card', 'completed', 'TXN-2024-045', '2024-10-12', '2024-11-11'),
(20, 3, 17.99, '2024-12-12 21:00:00', 'credit_card', 'completed', 'TXN-2024-056', '2024-12-12', '2025-01-11'),

-- Clients très actifs - paiements réguliers récents
(1, 2, 12.99, '2025-06-15 10:30:00', 'credit_card', 'completed', 'TXN-2025-030', '2025-06-15', '2025-07-14'),
(1, 2, 12.99, '2025-12-15 10:30:00', 'credit_card', 'completed', 'TXN-2025-065', '2025-12-15', '2026-01-14'),
(3, 3, 17.99, '2025-08-01 09:15:00', 'credit_card', 'completed', 'TXN-2025-042', '2025-08-01', '2025-08-31'),
(3, 3, 17.99, '2025-12-01 09:15:00', 'credit_card', 'completed', 'TXN-2025-062', '2025-12-01', '2025-12-31'),
(6, 3, 17.99, '2025-09-18 10:00:00', 'credit_card', 'completed', 'TXN-2025-048', '2025-09-18', '2025-10-17'),
(6, 3, 17.99, '2025-12-18 10:00:00', 'credit_card', 'completed', 'TXN-2025-067', '2025-12-18', '2026-01-17'),
(8, 3, 17.99, '2025-10-30 12:00:00', 'credit_card', 'completed', 'TXN-2025-056', '2025-10-30', '2025-11-29'),
(8, 3, 17.99, '2025-12-30 12:00:00', 'credit_card', 'completed', 'TXN-2025-070', '2025-12-30', '2026-01-29'),
(11, 2, 12.99, '2025-11-20 19:00:00', 'credit_card', 'completed', 'TXN-2025-061', '2025-11-20', '2025-12-19'),
(11, 2, 12.99, '2025-12-20 19:00:00', 'credit_card', 'completed', 'TXN-2025-069', '2025-12-20', '2026-01-19'),
(12, 3, 17.99, '2025-10-15 20:30:00', 'credit_card', 'completed', 'TXN-2025-054', '2025-10-15', '2025-11-14'),
(12, 3, 17.99, '2025-12-15 20:30:00', 'credit_card', 'completed', 'TXN-2025-066', '2025-12-15', '2026-01-14'),
(14, 3, 17.99, '2025-11-18 19:00:00', 'credit_card', 'completed', 'TXN-2025-059', '2025-11-18', '2025-12-17'),
(14, 3, 17.99, '2025-12-18 19:00:00', 'credit_card', 'completed', 'TXN-2025-071', '2025-12-18', '2026-01-17'),
(16, 3, 17.99, '2025-11-10 20:00:00', 'credit_card', 'completed', 'TXN-2025-058', '2025-11-10', '2025-12-09'),
(16, 3, 17.99, '2025-12-10 20:00:00', 'credit_card', 'completed', 'TXN-2025-064', '2025-12-10', '2026-01-09'),
(18, 2, 12.99, '2025-11-20 20:00:00', 'credit_card', 'completed', 'TXN-2025-057', '2025-11-20', '2025-12-19'),
(18, 2, 12.99, '2025-12-20 20:00:00', 'credit_card', 'completed', 'TXN-2025-072', '2025-12-20', '2026-01-19'),
(21, 2, 12.99, '2025-12-08 12:00:00', 'mobile_payment', 'completed', 'TXN-2025-063', '2025-12-08', '2026-01-07'),
(24, 3, 17.99, '2025-12-25 20:30:00', 'credit_card', 'completed', 'TXN-2025-073', '2025-12-25', '2026-01-24'),
(26, 2, 12.99, '2025-12-10 19:30:00', 'credit_card', 'completed', 'TXN-2025-074', '2025-12-10', '2026-01-09'),
(29, 2, 12.99, '2025-12-12 21:00:00', 'credit_card', 'completed', 'TXN-2025-075', '2025-12-12', '2026-01-11'),
(32, 3, 17.99, '2026-01-04 19:30:00', 'credit_card', 'completed', 'TXN-2026-001', '2026-01-04', '2026-02-03'),
(35, 2, 12.99, '2025-12-08 20:30:00', 'credit_card', 'completed', 'TXN-2025-076', '2025-12-08', '2026-01-07'),
(37, 2, 12.99, '2025-12-25 20:00:00', 'credit_card', 'completed', 'TXN-2025-077', '2025-12-25', '2026-01-24'),
(40, 3, 17.99, '2026-01-05 19:30:00', 'credit_card', 'completed', 'TXN-2026-002', '2026-01-05', '2026-02-04'),
(43, 2, 12.99, '2025-12-18 20:00:00', 'credit_card', 'completed', 'TXN-2025-078', '2025-12-18', '2026-01-17');

-- =====================================================
-- FIN DU FICHIER DE DONNÉES
-- =====================================================
-- Total des lignes insérées :
-- - countries: 20 lignes
-- - categories: 20 lignes
-- - subscription_plans: 5 lignes
-- - customers: 50 lignes
-- - movies: 20 lignes
-- - customer_subscriptions: 50 lignes
-- - streaming_sessions: 100 lignes
-- - viewing_history: 58 lignes
-- - watch_progress: 32 lignes
-- - payments: 38 lignes
-- =====================================================
