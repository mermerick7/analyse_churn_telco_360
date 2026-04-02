# 📊 Analyse du Churn Client — Telco 360

## 🎯 Contexte & Problématique

Dans le secteur des télécommunications, le churn (résiliation client) 
représente un enjeu majeur. Ce projet vise à **identifier les profils 
de clients les plus susceptibles de résilier** leur abonnement afin de 
proposer des actions de rétention ciblées et réduire le taux de churn.

**Dataset** : IBM Telco Customer Churn — 7 043 clients, 21 variables

---

## 🔍 Résultats Clés

| Indicateur | Valeur |
|-----------|--------|
| Taux de churn global | **26.54%** |
| Churn Month-to-month + Fiber optic | **54.61%** |
| Churn clients < 12 mois | **47.68%** |
| Churn contrat Two year | **2.8%** |
| ROC AUC (LightGBM) | **0.858** |

---

## 💡 Insights Business

- 🚨 **1 client sur 2** en contrat mensuel avec la fibre résilie
- 📅 **Les 12 premiers mois** sont critiques — taux de churn de 47.68%
- 💳 Les clients payant par **electronic check churent à 45.3%**
- ✅ Passer un client en **contrat annuel réduit le churn de 43% à 19%**

---

## 🛠️ Stack Technique

| Outil | Usage |
|-------|-------|
| Python (Pandas, Seaborn, Matplotlib) | EDA & Visualisation |
| Dataiku DSS | Pipeline ML & Modélisation |
| LightGBM | Modèle prédictif (ROC AUC : 0.858) |
| PostgreSQL / pgAdmin | Extraction & Requêtes SQL |
| Tableau Public | Dashboard interactif |

---

## 🗂️ Architecture du Projet
```
analyse_churn_telco_360/
│
├── 📓 notebook/
│   └── analyse_churn_telco_360.ipynb   # EDA complète en Python
│
├── 🗄️ sql/
│   └── requetes_churn.sql              # Requêtes PostgreSQL
│
├── 📊 visualisations/
│   ├── 01_distribution_churn.png
│   ├── 02_churn_par_variables.png
│   ├── 03_distributions_numeriques.png
│   ├── 04_matrice_correlation.png
│   └── 05_profil_churner.png
│
└── README.md
```

---

## 📈 Dashboard Tableau Public

👉 [Voir le dashboard interactif](https://public.tableau.com/views/AnalyseChurnTelco360/DashboardchurnTelco)

![Dashboard Preview](visualisations/05_profil_churner.png)

---

## 🔧 Méthodologie

### 1. Exploration des données (EDA)
- Analyse de la distribution du churn (26.54% de churners)
- Identification des variables clés via visualisations
- Détection du déséquilibre des classes (73/27)

### 2. Modélisation sur Dataiku
- Comparaison de 4 algorithmes : Random Forest, Logistic Regression, 
  XGBoost, LightGBM
- Gestion du déséquilibre via **Class Weights**
- Optimisation sur **ROC AUC**
- **LightGBM sélectionné** : meilleur équilibre performance/robustesse

### 3. Performances du modèle

| Métrique | Score |
|---------|-------|
| ROC AUC | 0.858 |
| Accuracy | 81% |
| Précision | 62% |
| Recall | 69% |
| F1-Score | 66% |

### 4. Extraction SQL
- Taux de churn global et par segment
- Identification des clients VIP à risque
- Analyse croisée contrat × service internet

---

## 🎯 Recommandations Business

1. **Priorité 1** : Cibler les clients Fiber optic en contrat mensuel 
   avec moins de 12 mois d'ancienneté → taux de churn 54.61%
2. **Priorité 2** : Inciter les clients Month-to-month à passer en 
   contrat annuel → réduit le churn de 43% à 19%
3. **Priorité 3** : Proposer le prélèvement automatique aux clients 
   payant par electronic check → réduction estimée du churn de 45% à 15%

---

## 👤 Auteur

**Mérick** | Data Analyst  
[LinkedIn](https://www.linkedin.com/in/merick-zounon/) | [Tableau Public](https://public.tableau.com/views/AnalyseChurnTelco360/DashboardchurnTelco)
