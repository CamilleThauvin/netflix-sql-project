"""
Dashboard Streamlit - Analyse du Risque de Churn Netflix
Projet MBA Big Data & IA - Janvier 2026
"""

import streamlit as st
import psycopg2
import pandas as pd
import plotly.express as px
import plotly.graph_objects as go
from datetime import datetime, timedelta

# Configuration de la page
st.set_page_config(
    page_title="Netflix Churn Dashboard",
    page_icon="📊",
    layout="wide",
    initial_sidebar_state="expanded"
)

# Style CSS personnalisé
st.markdown("""
    <style>
    .main-header {
        font-size: 2.5rem;
        color: #E50914;
        font-weight: bold;
        text-align: center;
        padding: 1rem;
    }
    .metric-card {
        background-color: #f0f2f6;
        padding: 1.5rem;
        border-radius: 10px;
        box-shadow: 2px 2px 10px rgba(0,0,0,0.1);
    }
    .alert-high {
        background-color: #ffcccc;
        padding: 1rem;
        border-left: 5px solid #E50914;
        border-radius: 5px;
        margin: 1rem 0;
    }
    .alert-medium {
        background-color: #fff4cc;
        padding: 1rem;
        border-left: 5px solid #FFA500;
        border-radius: 5px;
        margin: 1rem 0;
    }
    .alert-low {
        background-color: #ccffcc;
        padding: 1rem;
        border-left: 5px solid #28a745;
        border-radius: 5px;
        margin: 1rem 0;
    }
    </style>
""", unsafe_allow_html=True)

# Fonction de connexion à la base de données
@st.cache_resource
def init_connection():
    """Initialise la connexion à PostgreSQL"""
    return psycopg2.connect(
        host=st.secrets.get("DB_HOST", "localhost"),
        port=st.secrets.get("DB_PORT", 5432),
        database=st.secrets.get("DB_NAME", "netflix_db"),
        user=st.secrets.get("DB_USER", "postgres"),
        password=st.secrets.get("DB_PASSWORD", "")
    )

# Fonction pour exécuter les requêtes SQL
@st.cache_data(ttl=300)
def run_query(query):
    """Exécute une requête SQL et retourne un DataFrame"""
    conn = init_connection()
    df = pd.read_sql_query(query, conn)
    return df

# Requêtes SQL
def get_churn_metrics():
    """Récupère les métriques de churn globales"""
    query = """
    WITH customer_status AS (
        SELECT
            c.customer_id,
            CASE
                WHEN MAX(ss.session_start_time) IS NULL THEN TRUE
                WHEN EXTRACT(DAY FROM NOW() - MAX(ss.session_start_time)) > 60 THEN TRUE
                WHEN MAX(p.payment_date) IS NOT NULL
                     AND EXTRACT(DAY FROM NOW() - MAX(p.payment_date)) > 45 THEN TRUE
                ELSE FALSE
            END AS is_churned
        FROM customers c
        LEFT JOIN streaming_sessions ss ON ss.customer_id = c.customer_id
        LEFT JOIN payments p ON p.customer_id = c.customer_id AND p.payment_status = 'completed'
        GROUP BY c.customer_id
    )
    SELECT
        COUNT(*) AS total_clients,
        COUNT(CASE WHEN is_churned = FALSE THEN 1 END) AS clients_actifs,
        COUNT(CASE WHEN is_churned = TRUE THEN 1 END) AS clients_churnes,
        ROUND(100.0 * COUNT(CASE WHEN is_churned = TRUE THEN 1 END)::numeric / COUNT(*), 1) AS churn_rate_pct
    FROM customer_status;
    """
    return run_query(query)

def get_churn_by_plan():
    """Analyse du churn par plan d'abonnement"""
    query = """
    WITH customer_status AS (
        SELECT
            c.customer_id,
            cs.plan_id,
            COALESCE(EXTRACT(DAY FROM NOW() - MAX(ss.session_start_time)), 999) AS days_since_last_session,
            COALESCE(MAX(p.payment_date), c.signup_date) AS last_payment_date,
            EXTRACT(DAY FROM NOW() - COALESCE(MAX(p.payment_date), c.signup_date)) AS days_since_last_payment,
            CASE
                WHEN MAX(ss.session_start_time) IS NULL THEN TRUE
                WHEN EXTRACT(DAY FROM NOW() - MAX(ss.session_start_time)) > 60 THEN TRUE
                WHEN MAX(p.payment_date) IS NOT NULL
                     AND EXTRACT(DAY FROM NOW() - MAX(p.payment_date)) > 45 THEN TRUE
                ELSE FALSE
            END AS is_churned
        FROM customers c
        LEFT JOIN customer_subscriptions cs ON cs.customer_id = c.customer_id AND cs.is_current = TRUE
        LEFT JOIN streaming_sessions ss ON ss.customer_id = c.customer_id
        LEFT JOIN payments p ON p.customer_id = c.customer_id AND p.payment_status = 'completed'
        GROUP BY c.customer_id, cs.plan_id, c.signup_date
    )
    SELECT
        sp.plan_name,
        sp.monthly_price,
        COUNT(cs_status.customer_id) AS total_customers,
        COUNT(CASE WHEN cs_status.is_churned = TRUE THEN 1 END) AS churned_customers,
        ROUND(100.0 * COUNT(CASE WHEN cs_status.is_churned = TRUE THEN 1 END)::numeric / NULLIF(COUNT(cs_status.customer_id), 0), 1) AS churn_rate_pct
    FROM subscription_plans sp
    LEFT JOIN customer_subscriptions cs ON cs.plan_id = sp.plan_id AND cs.is_current = TRUE
    LEFT JOIN customer_status cs_status ON cs_status.plan_id = sp.plan_id
    GROUP BY sp.plan_name, sp.monthly_price
    ORDER BY churn_rate_pct DESC NULLS LAST;
    """
    return run_query(query)

def get_at_risk_customers():
    """Identifie les clients à risque de churn"""
    query = """
    WITH customer_engagement AS (
        SELECT
            c.customer_id,
            c.first_name,
            c.last_name,
            c.email,
            c.signup_date,
            COALESCE(sp.plan_name, 'Aucun plan') AS plan_name,
            COALESCE(sp.monthly_price, 0) AS monthly_price,
            COUNT(ss.session_id) AS total_sessions,
            COALESCE(SUM(ss.session_duration_minutes), 0) AS total_watch_time,
            MAX(ss.session_start_time) AS last_session_date,
            COALESCE(EXTRACT(DAY FROM NOW() - MAX(ss.session_start_time)), 999) AS days_since_last_session,
            MAX(p.payment_date) AS last_payment_date,
            COALESCE(EXTRACT(DAY FROM NOW() - MAX(p.payment_date)), 999) AS days_since_last_payment,
            COUNT(CASE WHEN p.payment_status = 'failed' THEN 1 END) AS failed_payments
        FROM customers c
        LEFT JOIN customer_subscriptions cs ON cs.customer_id = c.customer_id AND cs.is_current = TRUE
        LEFT JOIN subscription_plans sp ON sp.plan_id = cs.plan_id
        LEFT JOIN streaming_sessions ss ON ss.customer_id = c.customer_id
        LEFT JOIN payments p ON p.customer_id = c.customer_id
        GROUP BY c.customer_id, c.first_name, c.last_name, c.email, c.signup_date, sp.plan_name, sp.monthly_price
    )
    SELECT
        customer_id,
        first_name,
        last_name,
        email,
        signup_date,
        plan_name,
        monthly_price,
        total_sessions,
        total_watch_time,
        last_session_date,
        CASE
            WHEN days_since_last_session = 999 THEN NULL
            ELSE days_since_last_session
        END AS days_since_last_session,
        CASE
            WHEN days_since_last_payment = 999 THEN NULL
            ELSE days_since_last_payment
        END AS days_since_last_payment,
        failed_payments,
        CASE
            WHEN total_sessions = 0 AND days_since_last_payment > 60 THEN 'CRITIQUE'
            WHEN total_sessions = 0 THEN 'ÉLEVÉ'
            WHEN days_since_last_session > 60 THEN 'CRITIQUE'
            WHEN days_since_last_session > 30 OR days_since_last_session = 999 THEN 'ÉLEVÉ'
            WHEN (days_since_last_session > 14 AND total_watch_time < 100) OR failed_payments > 0 THEN 'MOYEN'
            ELSE 'FAIBLE'
        END AS risque_churn
    FROM customer_engagement
    ORDER BY
        CASE
            WHEN total_sessions = 0 AND days_since_last_payment > 60 THEN 1
            WHEN total_sessions = 0 THEN 2
            WHEN days_since_last_session > 60 THEN 3
            WHEN days_since_last_session > 30 OR days_since_last_session = 999 THEN 4
            WHEN (days_since_last_session > 14 AND total_watch_time < 100) OR failed_payments > 0 THEN 5
            ELSE 6
        END,
        days_since_last_session DESC NULLS FIRST;
    """
    return run_query(query)

def get_engagement_by_plan():
    """Temps de visionnage moyen par plan"""
    query = """
    SELECT
        p.plan_name,
        p.monthly_price,
        COUNT(DISTINCT cs.customer_id) AS subscribers_count,
        COUNT(s.session_id) AS total_sessions,
        COALESCE(SUM(s.session_duration_minutes), 0) AS total_watch_time_minutes,
        CASE
            WHEN COUNT(DISTINCT cs.customer_id) = 0 THEN 0
            ELSE ROUND(
                1.0 * COALESCE(SUM(s.session_duration_minutes), 0)
                / COUNT(DISTINCT cs.customer_id),
                1
            )
        END AS avg_watch_time_per_subscriber
    FROM subscription_plans p
    LEFT JOIN customer_subscriptions cs ON cs.plan_id = p.plan_id AND cs.is_current = TRUE
    LEFT JOIN streaming_sessions s ON s.customer_id = cs.customer_id
    GROUP BY p.plan_name, p.monthly_price
    ORDER BY avg_watch_time_per_subscriber DESC;
    """
    return run_query(query)

def get_payment_metrics():
    """Statistiques sur les paiements"""
    query = """
    SELECT
        COUNT(*) AS total_payments,
        COUNT(CASE WHEN payment_status = 'completed' THEN 1 END) AS successful_payments,
        COUNT(CASE WHEN payment_status = 'failed' THEN 1 END) AS failed_payments,
        COUNT(CASE WHEN payment_status = 'refunded' THEN 1 END) AS refunded_payments,
        ROUND(100.0 * COUNT(CASE WHEN payment_status = 'failed' THEN 1 END)::numeric / COUNT(*), 1) AS failed_rate_pct,
        SUM(CASE WHEN payment_status = 'completed' THEN amount ELSE 0 END) AS total_revenue
    FROM payments
    WHERE payment_date >= CURRENT_DATE - INTERVAL '30 days';
    """
    return run_query(query)

def get_activity_distribution():
    """Distribution de l'activité des clients"""
    query = """
    WITH customer_activity AS (
        SELECT
            c.customer_id,
            COALESCE(EXTRACT(DAY FROM NOW() - MAX(ss.session_start_time)), 999) AS days_since_last_session
        FROM customers c
        LEFT JOIN streaming_sessions ss ON ss.customer_id = c.customer_id
        GROUP BY c.customer_id
    ),
    categorized_activity AS (
        SELECT
            CASE
                WHEN days_since_last_session <= 7 THEN 'Actif (< 7 jours)'
                WHEN days_since_last_session <= 30 THEN 'Modéré (7-30 jours)'
                WHEN days_since_last_session <= 60 THEN 'À risque (30-60 jours)'
                ELSE 'Inactif (> 60 jours)'
            END AS activite_category,
            CASE
                WHEN days_since_last_session <= 7 THEN 1
                WHEN days_since_last_session <= 30 THEN 2
                WHEN days_since_last_session <= 60 THEN 3
                ELSE 4
            END AS category_order
        FROM customer_activity
    )
    SELECT
        activite_category,
        COUNT(*) AS nb_clients
    FROM categorized_activity
    GROUP BY activite_category, category_order
    ORDER BY category_order;
    """
    return run_query(query)

# Interface principale
def main():
    # En-tête
    st.markdown('<h1 class="main-header">📊 Netflix Churn Dashboard</h1>', unsafe_allow_html=True)
    st.markdown("---")

    # Sidebar - Paramètres
    with st.sidebar:
        st.image("https://upload.wikimedia.org/wikipedia/commons/0/08/Netflix_2015_logo.svg", width=200)
        st.markdown("## 🎯 Paramètres")

        auto_refresh = st.checkbox("Actualisation automatique (5 min)", value=False)

        st.markdown("---")
        st.markdown("### 📖 Définitions")
        st.info("""
        **Risque de Churn :**
        - 🔴 **CRITIQUE** : Inactif > 60 jours ou aucune session + pas de paiement
        - 🟠 **ÉLEVÉ** : Inactif > 30 jours ou aucune session
        - 🟡 **MOYEN** : Inactif > 14 jours avec faible engagement ou paiement échoué
        - 🟢 **FAIBLE** : Utilisateur actif (< 14 jours)
        """)

    # Métriques globales
    st.header("📈 Vue d'ensemble")

    try:
        metrics = get_churn_metrics()

        col1, col2, col3, col4 = st.columns(4)

        with col1:
            st.metric(
                label="Total Clients",
                value=int(metrics['total_clients'].values[0]),
                delta=None
            )

        with col2:
            st.metric(
                label="Clients Actifs",
                value=int(metrics['clients_actifs'].values[0]),
                delta=f"+{int(metrics['clients_actifs'].values[0])} actifs",
                delta_color="normal"
            )

        with col3:
            st.metric(
                label="Clients Churnés",
                value=int(metrics['clients_churnes'].values[0]),
                delta=f"-{int(metrics['clients_churnes'].values[0])} perdus",
                delta_color="inverse"
            )

        with col4:
            churn_rate = float(metrics['churn_rate_pct'].values[0])
            st.metric(
                label="Taux de Churn",
                value=f"{churn_rate}%",
                delta=f"{churn_rate}% de perte",
                delta_color="inverse"
            )

        st.markdown("---")

        # Distribution de l'activité et paiements
        st.header("📊 Distribution de l'Activité Client")

        col1, col2 = st.columns(2)

        with col1:
            # Graphique de distribution d'activité
            activity_dist = get_activity_distribution()

            fig_activity = px.pie(
                activity_dist,
                values='nb_clients',
                names='activite_category',
                title='Répartition des Clients par Niveau d\'Activité',
                color='activite_category',
                color_discrete_map={
                    'Actif (< 7 jours)': '#28a745',
                    'Modéré (7-30 jours)': '#FFA500',
                    'À risque (30-60 jours)': '#FF6347',
                    'Inactif (> 60 jours)': '#E50914'
                }
            )
            fig_activity.update_traces(textposition='inside', textinfo='percent+label')
            st.plotly_chart(fig_activity, use_container_width=True)

        with col2:
            # Métriques de paiement
            payment_metrics = get_payment_metrics()

            st.subheader("💳 Statistiques Paiements (30 derniers jours)")

            col_a, col_b = st.columns(2)
            with col_a:
                st.metric(
                    "Paiements Réussis",
                    int(payment_metrics['successful_payments'].values[0])
                )
                st.metric(
                    "Paiements Échoués",
                    int(payment_metrics['failed_payments'].values[0]),
                    delta=f"{float(payment_metrics['failed_rate_pct'].values[0])}%",
                    delta_color="inverse"
                )

            with col_b:
                st.metric(
                    "Remboursements",
                    int(payment_metrics['refunded_payments'].values[0])
                )
                revenue = float(payment_metrics['total_revenue'].values[0])
                st.metric(
                    "Revenus",
                    f"{revenue:,.2f} €"
                )

        st.markdown("---")

        # Analyse par plan
        st.header("📊 Analyse par Plan d'Abonnement")

        col1, col2 = st.columns(2)

        with col1:
            churn_by_plan = get_churn_by_plan()

            # Graphique en barres
            fig_plan = px.bar(
                churn_by_plan,
                x='plan_name',
                y='churn_rate_pct',
                title='Taux de Churn par Plan',
                labels={'plan_name': 'Plan', 'churn_rate_pct': 'Taux de Churn (%)'},
                color='churn_rate_pct',
                color_continuous_scale=['#28a745', '#FFA500', '#E50914']
            )
            st.plotly_chart(fig_plan, use_container_width=True)

        with col2:
            engagement = get_engagement_by_plan()

            # Graphique engagement
            fig_engagement = px.bar(
                engagement,
                x='plan_name',
                y='avg_watch_time_per_subscriber',
                title='Temps de Visionnage Moyen par Plan',
                labels={'plan_name': 'Plan', 'avg_watch_time_per_subscriber': 'Minutes / Client'},
                color='avg_watch_time_per_subscriber',
                color_continuous_scale='Blues'
            )
            st.plotly_chart(fig_engagement, use_container_width=True)

        st.markdown("---")

        # Clients à risque
        st.header("⚠️ Clients à Risque de Churn")

        at_risk = get_at_risk_customers()

        # Comptage par niveau de risque
        risk_counts = at_risk['risque_churn'].value_counts().to_dict()

        col1, col2, col3, col4 = st.columns(4)

        with col1:
            st.metric("🔴 Risque CRITIQUE", risk_counts.get('CRITIQUE', 0))
        with col2:
            st.metric("🟠 Risque ÉLEVÉ", risk_counts.get('ÉLEVÉ', 0))
        with col3:
            st.metric("🟡 Risque MOYEN", risk_counts.get('MOYEN', 0))
        with col4:
            st.metric("🟢 Risque FAIBLE", risk_counts.get('FAIBLE', 0))

        # Filtres
        st.subheader("🔍 Filtrer les clients")

        col1, col2 = st.columns(2)

        with col1:
            risk_filter = st.multiselect(
                "Niveau de risque",
                options=['CRITIQUE', 'ÉLEVÉ', 'MOYEN', 'FAIBLE'],
                default=['CRITIQUE', 'ÉLEVÉ']
            )

        with col2:
            plan_filter = st.multiselect(
                "Plan d'abonnement",
                options=at_risk['plan_name'].unique().tolist(),
                default=at_risk['plan_name'].unique().tolist()
            )

        # Application des filtres
        filtered_customers = at_risk[
            (at_risk['risque_churn'].isin(risk_filter)) &
            (at_risk['plan_name'].isin(plan_filter))
        ]

        # Tableau des clients à risque
        st.subheader(f"📋 Liste des clients ({len(filtered_customers)} clients)")

        # Formatage du tableau
        display_df = filtered_customers[[
            'first_name', 'last_name', 'email', 'plan_name', 'monthly_price',
            'total_sessions', 'total_watch_time', 'days_since_last_session',
            'days_since_last_payment', 'failed_payments', 'risque_churn'
        ]].copy()

        display_df.columns = [
            'Prénom', 'Nom', 'Email', 'Plan', 'Prix (€)',
            'Sessions', 'Temps total (min)', 'Jours sans session',
            'Jours sans paiement', 'Paiements échoués', 'Risque'
        ]

        # Coloration par risque
        def color_risk(val):
            if val == 'CRITIQUE':
                return 'background-color: #ffcccc'
            elif val == 'ÉLEVÉ':
                return 'background-color: #ffddaa'
            elif val == 'MOYEN':
                return 'background-color: #ffffcc'
            else:
                return 'background-color: #ccffcc'

        styled_df = display_df.style.applymap(color_risk, subset=['Risque'])

        st.dataframe(styled_df, use_container_width=True, height=400)

        # Actions recommandées
        st.markdown("---")
        st.header("💡 Actions Recommandées")

        critical_count = risk_counts.get('CRITIQUE', 0)
        high_count = risk_counts.get('ÉLEVÉ', 0)

        if critical_count > 0:
            st.markdown(f"""
            <div class="alert-high">
                <strong>🔴 ALERTE CRITIQUE : {critical_count} client(s) sans aucune session !</strong><br>
                <strong>Actions immédiates :</strong>
                <ul>
                    <li>Envoyer un email de réengagement personnalisé</li>
                    <li>Proposer une offre exclusive ou un mois gratuit</li>
                    <li>Appel téléphonique du service client</li>
                </ul>
            </div>
            """, unsafe_allow_html=True)

        if high_count > 0:
            st.markdown(f"""
            <div class="alert-medium">
                <strong>🟠 ALERTE ÉLEVÉE : {high_count} client(s) inactif(s) depuis plus de 30 jours</strong><br>
                <strong>Actions recommandées :</strong>
                <ul>
                    <li>Campagne email avec recommandations personnalisées</li>
                    <li>Notification push sur nouveaux contenus</li>
                    <li>Survey de satisfaction pour comprendre les raisons</li>
                </ul>
            </div>
            """, unsafe_allow_html=True)

        # Export des données
        st.markdown("---")
        st.subheader("📥 Exporter les données")

        csv = filtered_customers.to_csv(index=False).encode('utf-8')
        st.download_button(
            label="Télécharger la liste des clients à risque (CSV)",
            data=csv,
            file_name=f'clients_risque_churn_{datetime.now().strftime("%Y%m%d")}.csv',
            mime='text/csv'
        )

    except Exception as e:
        st.error(f"Erreur lors de la récupération des données : {str(e)}")
        st.info("Vérifiez que la base de données PostgreSQL est démarrée et accessible.")
        st.code("""
        Configuration requise dans .streamlit/secrets.toml :

        DB_HOST = "localhost"
        DB_PORT = 5432
        DB_NAME = "netflix_db"
        DB_USER = "postgres"
        DB_PASSWORD = "votre_mot_de_passe"
        """)

if __name__ == "__main__":
    main()
