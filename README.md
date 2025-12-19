# netflix-sql-project
Projet SQL - Évolution de Netflix (Abonnements + Streaming + Analytics)
# Netflix SQL Project

Mini-projet de base de données et d'analytics inspiré de Netflix.  
Objectif : modéliser des clients, abonnements et données de streaming pour écrire des requêtes SQL d'analyse.

## Structure de la base de données

Tables principales :

- `customers` : infos clients (nom, email, pays, date d'inscription, statut actif).
- `customer_subscriptions` : historique des abonnements par client (plan, dates, is_current).
- `subscription_plans` : détails des plans (nom, prix mensuel, qualité, écrans max).
- `streaming_sessions` : sessions de visionnage (client, film, durée, device).
- `categories`, `countries` : référentiels pour les genres et les pays.

## Organisation des fichiers

- `tables/` : scripts de création des tables (DDL).
- `data/` : jeux de données de test (INSERT).
- `queries/streaming/` : requêtes d'analytics liées au streaming  
  - `top_10_films.sql`  
  - `watch_time_by_user.sql`  
  - `watch_time_by_device.sql`  
  - `daily_watch_time.sql`  
- `queries/subscriptions/` : requêtes d'analytics sur les abonnements  
  - `revenue_by_plan.sql`  
  - `plan_changes.sql`

## Comment recréer la base

1. Créer une base PostgreSQL vide.
2. Exécuter les scripts du dossier `tables/` pour créer les tables.
3. Charger les données de test depuis `data/` (ex. `streaming_sample.sql`).
4. Lancer les requêtes du dossier `queries/` dans pgAdmin pour obtenir les indicateurs.

## Analytics disponibles

Exemples d'analyses fournies par les requêtes :

- Top 10 des films par temps total de visionnage.
- Temps de visionnage par utilisateur et par device.
- Répartition et revenu théorique par type de plan d'abonnement.
- Nombre de changements de plan par client.
