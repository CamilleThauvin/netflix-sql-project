-- =====================================================
-- SCRIPT D'INITIALISATION DE LA BASE DE DONNÉES NETFLIX
-- =====================================================
-- Ce script crée toutes les tables dans le bon ordre
-- et charge les données de test
--
-- UTILISATION :
-- psql -U votre_user -d votre_database -f init_database.sql
--
-- OU depuis pgAdmin :
-- Ouvrir ce fichier et l'exécuter
-- =====================================================

\echo '=================================================='
\echo 'INITIALISATION DE LA BASE DE DONNÉES NETFLIX'
\echo '=================================================='
\echo ''

-- =====================================================
-- ÉTAPE 1 : SUPPRESSION DES TABLES EXISTANTES
-- =====================================================
\echo '1. Suppression des tables existantes (si elles existent)...'

DROP TABLE IF EXISTS viewing_history CASCADE;
DROP TABLE IF EXISTS streaming_sessions CASCADE;
DROP TABLE IF EXISTS watch_progress CASCADE;
DROP TABLE IF EXISTS payments CASCADE;
DROP TABLE IF EXISTS customer_subscriptions CASCADE;
DROP TABLE IF EXISTS movies CASCADE;
DROP TABLE IF EXISTS customers CASCADE;
DROP TABLE IF EXISTS subscription_plans CASCADE;
DROP TABLE IF EXISTS categories CASCADE;
DROP TABLE IF EXISTS countries CASCADE;

\echo '   ✓ Tables supprimées'
\echo ''

-- =====================================================
-- ÉTAPE 2 : CRÉATION DES TABLES DE RÉFÉRENCE
-- =====================================================
\echo '2. Création des tables de référence...'

-- Table COUNTRIES
\i 'tables/countries.sql'
\echo '   ✓ Table countries créée'

-- Table CATEGORIES
\i 'tables/categories.sql'
\echo '   ✓ Table categories créée'

-- Table SUBSCRIPTION_PLANS
\i 'tables/subscriptions/01_subscription_plans.sql'
\echo '   ✓ Table subscription_plans créée'

\echo ''

-- =====================================================
-- ÉTAPE 3 : CRÉATION DES TABLES PRINCIPALES
-- =====================================================
\echo '3. Création des tables principales...'

-- Table CUSTOMERS
\i 'tables/subscriptions/00_customers.sql'
\echo '   ✓ Table customers créée'

-- Table MOVIES
\i 'tables/movies.sql'
\echo '   ✓ Table movies créée'

\echo ''

-- =====================================================
-- ÉTAPE 4 : CRÉATION DES TABLES DÉPENDANTES
-- =====================================================
\echo '4. Création des tables dépendantes...'

-- Tables d'abonnements
\i 'tables/subscriptions/02_customer_subscriptions.sql'
\echo '   ✓ Table customer_subscriptions créée'

\i 'tables/subscriptions/04_payments.sql'
\echo '   ✓ Table payments créée'

-- Tables de streaming
\i 'tables/streaming/01_streaming_sessions.sql'
\echo '   ✓ Table streaming_sessions créée'

\i 'tables/streaming/02_viewing_history.sql'
\echo '   ✓ Table viewing_history créée'

\i 'tables/streaming/03_watch_progress.sql'
\echo '   ✓ Table watch_progress créée'

\echo ''

-- =====================================================
-- ÉTAPE 5 : CHARGEMENT DES DONNÉES DE TEST
-- =====================================================
\echo '5. Chargement des données de test...'

\i 'data/complete_data.sql'
\echo '   ✓ Données chargées'

\echo ''

-- =====================================================
-- ÉTAPE 6 : VÉRIFICATION
-- =====================================================
\echo '6. Vérification des données...'
\echo ''

SELECT 'countries' AS table_name, COUNT(*) AS row_count FROM countries
UNION ALL
SELECT 'categories', COUNT(*) FROM categories
UNION ALL
SELECT 'subscription_plans', COUNT(*) FROM subscription_plans
UNION ALL
SELECT 'customers', COUNT(*) FROM customers
UNION ALL
SELECT 'movies', COUNT(*) FROM movies
UNION ALL
SELECT 'customer_subscriptions', COUNT(*) FROM customer_subscriptions
UNION ALL
SELECT 'payments', COUNT(*) FROM payments
UNION ALL
SELECT 'streaming_sessions', COUNT(*) FROM streaming_sessions
UNION ALL
SELECT 'viewing_history', COUNT(*) FROM viewing_history
UNION ALL
SELECT 'watch_progress', COUNT(*) FROM watch_progress
ORDER BY table_name;

\echo ''
\echo '=================================================='
\echo 'INITIALISATION TERMINÉE AVEC SUCCÈS !'
\echo '=================================================='
