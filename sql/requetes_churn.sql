-- ================================================
-- ANALYSE DU CHURN CLIENT — TELCO 360
-- Auteur : Mérick | Data Analyst
-- ================================================

-- 1. Taux de churn global
SELECT 
    COUNT(*) AS total_clients,
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS total_churners,
    SUM(CASE WHEN churn = 'No' THEN 1 ELSE 0 END) AS total_fideles,
    ROUND(100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS taux_churn_pct
FROM churn_data;

-- 2. Taux de churn par segment d'ancienneté
SELECT 
    CASE 
        WHEN tenure BETWEEN 1 AND 12 THEN '1. Nouveau (0-12 mois)'
        WHEN tenure BETWEEN 13 AND 24 THEN '2. Récent (13-24 mois)'
        WHEN tenure BETWEEN 25 AND 48 THEN '3. Intermédiaire (25-48 mois)'
        ELSE '4. Fidèle (49-72 mois)'
    END AS segment_anciennete,
    COUNT(*) AS total_clients,
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churners,
    ROUND(100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS taux_churn_pct
FROM churn_data
GROUP BY segment_anciennete
ORDER BY segment_anciennete;

-- 3. Clients VIP à risque
SELECT 
    customerid,
    tenure,
    contract,
    internetservice,
    monthlycharges,
    totalcharges,
    paymentmethod,
    churn,
    CASE 
        WHEN monthlycharges >= 85 THEN 'VIP Premium'
        WHEN monthlycharges >= 65 THEN 'VIP Standard'
        ELSE 'Standard'
    END AS segment_valeur,
    ROUND(monthlycharges * 12, 2) AS revenu_annuel_estime
FROM churn_data
WHERE churn = 'Yes'
    AND monthlycharges >= 65
    AND tenure <= 24
ORDER BY monthlycharges DESC
LIMIT 20;

-- 4. Synthèse business : Churn par contrat et service internet
SELECT 
    contract,
    internetservice,
    COUNT(*) AS total_clients,
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churners,
    ROUND(100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS taux_churn_pct,
    ROUND(AVG(monthlycharges), 2) AS charge_mensuelle_moy,
    ROUND(SUM(CASE WHEN churn = 'Yes' THEN monthlycharges ELSE 0 END) * 12, 2) AS revenu_annuel_perdu
FROM churn_data
GROUP BY contract, internetservice
ORDER BY taux_churn_pct DESC;
