# 🎬 Netflix SQL Project
**De la Location DVD au Streaming**

[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=flat&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![SQL](https://img.shields.io/badge/SQL-Database-blue)](https://www.w3schools.com/sql/)
[![Git](https://img.shields.io/badge/Git-Version%20Control-orange)](https://git-scm.com/)

---

## 📋 Table des Matières
- [À Propos du Projet](#-à-propos-du-projet)
- [Fonctionnalités](#-fonctionnalités)
- [Architecture de la Base de Données](#-architecture-de-la-base-de-données)
- [Installation et Configuration](#-installation-et-configuration)
- [Requêtes Analytics Disponibles](#-requêtes-analytics-disponibles)
- [Résultats et KPIs](#-résultats-et-kpis)
- [Structure du Projet](#-structure-du-projet)
- [Équipe](#-équipe)
- [Technologies Utilisées](#-technologies-utilisées)

---

## 🎯 À Propos du Projet

Ce projet simule l'évolution d'une base de données Netflix, de ses débuts en tant que service de location de DVD vers sa transformation en plateforme de streaming moderne. 

**Contexte Académique :** Projet SQL réalisé dans le cadre du MBA Big Data & IA, démontrant la maîtrise de la conception de bases de données relationnelles, des requêtes SQL complexes et de l'analyse de données.

### Objectifs Pédagogiques
- ✅ Conception et modélisation de bases de données relationnelles
- ✅ Maîtrise des concepts SQL avancés (JOIN, GROUP BY, agrégations)
- ✅ Création de requêtes analytiques pour générer des insights métier
- ✅ Gestion de projets collaboratifs avec Git/GitHub

---

## 🚀 Fonctionnalités

Notre projet se concentre sur **deux fonctionnalités principales** :

### 1. 📊 Système d'Abonnements Multi-niveaux
- Gestion de plans d'abonnement (Basic, Standard, Premium, Mobile, Family)
- Suivi de l'historique des abonnements par client
- Système de paiements avec méthodes multiples
- Analyse des changements de plans et du churn

### 2. 🎥 Système de Streaming et Analytics
- Sessions de visionnage avec tracking du temps et des appareils
- Historique complet de visionnage par client
- Progression de lecture avec bookmarks (reprendre là où on s'est arrêté)
- Analytics avancés : temps de visionnage, films populaires, engagement utilisateurs

---

## 🗄️ Architecture de la Base de Données

### Diagramme ERD
```
┌─────────────┐      ┌──────────────────┐      ┌─────────────────┐
│  countries  │      │ subscription_    │      │    customers    │
│             │      │    plans         │      │                 │
└─────────────┘      └──────────────────┘      └─────────────────┘
                              │                         │
                              │                         │
                              ▼                         ▼
┌─────────────┐      ┌──────────────────┐      ┌─────────────────┐
│ categories  │      │ customer_        │◄─────┤    payments     │
│             │      │ subscriptions    │      │                 │
└─────────────┘      └──────────────────┘      └─────────────────┘
       │                                               │
       │                                               │
       ▼                                               ▼
┌─────────────┐                            ┌─────────────────┐
│   movies    │◄───────────────────────────┤  streaming_     │
│             │                            │  sessions       │
└─────────────┘                            └─────────────────┘
       │                                               │
       │                                               │
       ▼                                               ▼
┌──────────────────┐                       ┌─────────────────┐
│ viewing_history  │                       │ watch_progress  │
│                  │                       │                 │
└──────────────────┘                       └─────────────────┘
```

### Tables Principales

#### 📑 **Référentiels**
- `countries` (20 pays) - Marchés Netflix internationaux
- `categories` (20 genres) - Genres de films/séries
- `subscription_plans` (5 plans) - Plans d'abonnement disponibles

#### 👥 **Gestion Clients**
- `customers` (50 clients) - Informations clients avec statut actif/inactif
- `customer_subscriptions` (50 abonnements) - Historique des abonnements
- `payments` (38 paiements) - Historique des transactions

#### 🎬 **Contenu**
- `movies` (20 films/séries) - Catalogue Netflix avec originals

#### 📺 **Streaming & Analytics**
- `streaming_sessions` (100 sessions) - Sessions de visionnage avec durée et device
- `viewing_history` (58 historiques) - Historique complet avec taux de complétion
- `watch_progress` (32 progressions) - Reprise de lecture avec position exacte

**Total : 10 tables interconnectées**

---

## ⚙️ Installation et Configuration

### Prérequis
- PostgreSQL 12+ installé
- pgAdmin ou un client SQL
- Git (pour cloner le projet)

### Installation

1. **Cloner le dépôt**
```bash
git clone https://github.com/lucaslgk/netflix-sql-project.git
cd netflix-sql-project
```

2. **Créer la base de données**
```sql
CREATE DATABASE netflix_db;
```

3. **Exécuter le script d'initialisation complet**

Option A - Via psql en ligne de commande :
```bash
psql -U votre_user -d netflix_db -f init_database.sql
```

Option B - Via pgAdmin :
1. Ouvrir pgAdmin
2. Se connecter à votre serveur PostgreSQL
3. Sélectionner la base `netflix_db`
4. Ouvrir l'outil de requête (Query Tool)
5. Charger et exécuter le fichier `init_database.sql`

Le script `init_database.sql` effectue automatiquement :
- ✅ Suppression des tables existantes
- ✅ Création de toutes les tables dans le bon ordre
- ✅ Chargement de 393 lignes de données de test réalistes
- ✅ Vérification de l'intégrité des données

### Vérification de l'Installation

Après l'exécution, vous devriez voir :
```
Résultat de la vérification :
┌──────────────────────┬───────────┐
│     table_name       │ row_count │
├──────────────────────┼───────────┤
│ categories           │    20     │
│ countries            │    20     │
│ customer_subscriptions│   50     │
│ customers            │    50     │
│ movies               │    20     │
│ payments             │    38     │
│ streaming_sessions   │   100     │
│ subscription_plans   │     5     │
│ viewing_history      │    58     │
│ watch_progress       │    32     │
└──────────────────────┴───────────┘
```

---

## 📊 Requêtes Analytics Disponibles

Notre projet propose **15+ requêtes SQL** réparties en 3 catégories :

### 🎯 Analytics Streaming

| Requête | Description | Complexité |
|---------|-------------|------------|
| `top_10_films.sql` | Top 10 des films par temps total de visionnage | ⭐⭐ JOIN + GROUP BY |
| `watch_time_by_user.sql` | Temps de visionnage par utilisateur | ⭐⭐ JOIN + Agrégation |
| `watch_time_by_device.sql` | Répartition par type d'appareil | ⭐ GROUP BY |
| `daily_watch_time.sql` | Temps de visionnage journalier | ⭐⭐ Date functions |
| `top_users_by_watch_time.sql` | Utilisateurs les plus actifs (TOP 10) | ⭐⭐ JOIN + LIMIT |
| `viewing_history_analysis.sql` | Analyse de l'historique avec taux de complétion | ⭐⭐⭐ Multiple JOINs |

### 💰 Analytics Abonnements

| Requête | Description | Complexité |
|---------|-------------|------------|
| `revenue_by_plan.sql` | Revenu mensuel et annuel par plan | ⭐⭐ LEFT JOIN + Agrégation |
| `plan_changes.sql` | Nombre de changements de plan par client | ⭐⭐⭐ GROUP BY + HAVING |
| `monthly_revenue.sql` | Dashboard global des revenus (CA mensuel/annuel) | ⭐⭐⭐ UNION ALL |

### 📈 Analytics Avancés

| Requête | Description | Complexité |
|---------|-------------|------------|
| `kpi_overview.sql` | KPIs globaux (clients, abonnements, sessions) | ⭐⭐ Subqueries |
| `customer_activity.sql` | Répartition actifs/inactifs + clients churned | ⭐⭐ Multiple queries |
| `churn_analysis.sql` | Taux de churn et clients à risque | ⭐⭐⭐ FILTER + Agrégations |
| `churn_rate.sql` | Calcul du taux de churn en pourcentage | ⭐⭐ CASE WHEN |
| `arpu_metrics.sql` | ARPU (Average Revenue Per User) par plan | ⭐⭐⭐ Complex calculation |
| `plan_streaming_engagement.sql` | Engagement par plan d'abonnement | ⭐⭐⭐⭐ Multiple LEFT JOINs |

**Légende :** ⭐ Simple | ⭐⭐ Moyen | ⭐⭐⭐ Avancé | ⭐⭐⭐⭐ Très avancé

---

## 📈 Résultats et KPIs

### KPIs Globaux
- **50 clients** inscrits (44 actifs, 6 churnés)
- **44 abonnements actifs** en cours
- **100 sessions de streaming** enregistrées
- **Total temps de visionnage :** 5,000+ minutes

### Insights Métier

#### 💵 Revenus
- **CA mensuel estimé :** ~600€/mois
- **CA annuel projeté :** ~7,200€/an
- **Plan le plus rentable :** Premium (17,99€/mois)

#### 📺 Engagement
- **Top 3 films les plus regardés :**
  1. Stranger Things (multiple sessions)
  2. Squid Game (très populaire en Asie)
  3. The Crown (audience UK forte)

- **Appareils préférés :**
  - TV : 65% des sessions
  - Mobile : 25% des sessions
  - Web : 10% des sessions

#### ⚠️ Churn Analysis
- **Taux de churn :** ~12% (6 clients sur 50)
- **Clients à risque :** Identifiés via l'analyse d'engagement

---

## 📁 Structure du Projet

```
netflix-sql-project/
│
├── 📄 README.md                          # Documentation principale
├── 📄 init_database.sql                  # Script d'initialisation complet
├── 📄 .gitignore                         # Fichiers Git ignorés
│
├── 📂 tables/                            # Scripts de création des tables (DDL)
│   ├── 📂 subscriptions/
│   │   ├── 00_customers.sql              # Table clients
│   │   ├── 01_subscription_plans.sql     # Plans d'abonnement
│   │   ├── 02_customer_subscriptions.sql # Abonnements clients
│   │   └── 04_payments.sql               # Paiements
│   │
│   ├── 📂 streaming/
│   │   ├── 01_streaming_sessions.sql     # Sessions de visionnage
│   │   ├── 02_viewing_history.sql        # Historique
│   │   └── 03_watch_progress.sql         # Progression de lecture
│   │
│   ├── movies.sql                        # Films et séries
│   ├── categories.sql                    # Genres
│   └── countries.sql                     # Pays
│
├── 📂 data/
│   └── complete_data.sql                 # Données de test (393 lignes)
│
└── 📂 queries/                           # Requêtes analytics (SELECT)
    ├── 📂 streaming/
    │   ├── top_10_films.sql
    │   ├── watch_time_by_user.sql
    │   ├── watch_time_by_device.sql
    │   ├── daily_watch_time.sql
    │   ├── top_users_by_watch_time.sql
    │   └── viewing_history_analysis.sql
    │
    ├── 📂 subscriptions/
    │   ├── revenue_by_plan.sql
    │   ├── plan_changes.sql
    │   └── monthly_revenue.sql
    │
    └── 📂 analytics/
        ├── kpi_overview.sql
        ├── customer_activity.sql
        ├── churn_analysis.sql
        ├── churn_rate.sql
        ├── arpu_metrics.sql
        └── plan_streaming_engagement.sql
```

---

## 👥 Équipe

**Projet réalisé par :**

| Nom | Rôle | Contribution Principale |
|-----|------|------------------------|
| Camille Thauvin | Project Manager | 3 tables référentiels + 1 requête analytics + Diagramme ERD |
| Ines Taibi | Business Analyst | 3 tables abonnements + 2 requêtes revenus |
| Myriam Benani | Streaming Product Manager | 2 tables streaming + 3 requêtes analytics visionnage |
| Ines Hideche | Data Analyst | 1 table movies + 3 requêtes analytics avancées (ARPU, engagement) |
| Aghilas Aissaoui | Data Quality Manager | 1 table streaming + 3 requêtes SELECT + Données de test |
| Lucas Goumard | Product Owner | 3 requêtes analytics (KPIs, churn) + Script init + Git/Documentation |

**Encadrement :** MBA Big Data & IA - Janvier 2026

---

## 🛠️ Technologies Utilisées

### Base de Données
- **PostgreSQL 12+** - Base de données relationnelle
- **pgAdmin 4** - Interface graphique pour PostgreSQL

### Versionning
- **Git** - Gestion de version
- **GitHub** - Hébergement du code source

### Développement
- **VSCode** - Éditeur de code
- **SQL** - Langage de requêtes

### Modélisation
- **dbdiagram.io** - Création de diagrammes ERD
- **Draw.io** - Diagrammes et schémas

---

## 📚 Ressources et Documentation

### Documentation Officielle
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [PostgreSQL Tutorial](https://www.postgresqltutorial.com/)
- [W3Schools SQL](https://www.w3schools.com/sql/)

### Bonnes Pratiques SQL
- Nommer les tables au pluriel (`customers`, `subscriptions`)
- Utiliser `snake_case` pour les colonnes (`customer_id`, `first_name`)
- Toujours définir une clé primaire (`PRIMARY KEY`)
- Commenter les requêtes complexes
- Utiliser des transactions pour les opérations critiques

---

## 🎓 Contexte Académique

### Objectifs Pédagogiques Atteints
✅ Application des concepts de normalisation de bases de données  
✅ Maîtrise des jointures (INNER JOIN, LEFT JOIN)  
✅ Utilisation avancée de GROUP BY, HAVING, agrégations  
✅ Création de requêtes analytiques complexes  
✅ Collaboration en équipe avec Git/GitHub  
✅ Documentation technique professionnelle  

### Critères d'Évaluation
- ✅ **Pertinence de la fonctionnalité** (10%) - Système d'abonnements + streaming
- ✅ **Qualité du modèle** (25%) - 10 tables normalisées avec contraintes
- ✅ **Qualité du code SQL** (30%) - 15+ requêtes fonctionnelles
- ✅ **Documentation** (10%) - README complet avec diagrammes
- ✅ **Travail d'équipe** (10%) - Répartition via Git branches

---

## 📄 Licence

Ce projet est réalisé dans un cadre académique pour le MBA Big Data & IA.

---

## 🙏 Remerciements

Merci à Monsieur François Cortezon ainsi qu'aux enseignants du MBA Big Data & IA pour leur accompagnement.

---


**Dernière mise à jour :07 Janvier 2026
