/* ═══════════════════════════════════════════════
   PROJECT: HEART ATTACK CASES ANALYSIS
   AUTHOR: Sania Jawed
   DATE: October 2025
   DATABASE: kaggle
   ═══════════════════════════════════════════════ */
   
   Create database heart_attack;
   Use heart_attack;
 
 #Query 1.1: Age Group Risk Distribution

-- Question: Which age group has the highest heart attack risk?
-- Business Impact: Helps target age-specific prevention programs
SELECT 
      Age, COUNT(*) AS total_cases
      from heart_attack
      where Heart_Attack_Risk= 1
      group by Age
      order by total_cases DESC ;

/* Expected Insights:
   - Identifies most vulnerable age demographics
   - Guides resource allocation for healthcare programs */
   
-- Query 1.2: Age-Gender Risk Intersection

-- Question: Which age and gender combinations are most at risk?
-- Business Impact: Enables gender-specific prevention strategies
SELECT 
      Age, Sex, COUNT(*) AS risk_cases
      from heart_attack
      where Heart_Attack_Risk= 1
      group by Age, Sex
      order by risk_cases DESC;
      
/* Expected Insights:
   - Reveals gender disparities within age groups
   - Supports targeted health campaigns */

-- Query 1.3: Geographic Risk Distribution

-- Question: Which countries report the highest number of heart attack risk cases?
-- Business Impact: Identifies regions needing immediate healthcare intervention
SELECT
      Country,  COUNT(*) AS risk_cases
      from heart_attack
      where Heart_Attack_Risk= 1
      group by Country
      order by risk_cases DESC;
      
/* Expected Insights:
   - Highlights countries with highest disease burden
   - Guides international health policy decisions */

-- Query 2.1: Overall Risk Distribution

-- Question: What is the overall distribution of heart attack risk?
-- Business Impact: Establishes baseline risk levels in population
SELECT 
    CASE WHEN Heart_Attack_Risk = 1 THEN 'At Risk' ELSE 'Not at Risk' END AS risk_status,
    COUNT(*) AS count,
    ROUND((COUNT(*) * 100.0) / (SELECT COUNT(*) FROM heart_attack), 2) AS percentage
FROM heart_attack
GROUP BY risk_status;

/* Expected Insights:
   - Shows proportion of high-risk vs low-risk patients
   - Helps assess overall population health status */

-- Query 2.2: Primary Risk Factors Ranking

-- Question: What are the most common risk factors among high-risk patients?
-- Business Impact: Prioritizes which risk factors to address first
SELECT 'Smoking' AS risk_factor, COUNT(*) 
        FROM heart_attack
        WHERE smoking = 1 AND Heart_Attack_Risk = 1
UNION ALL
SELECT 'Obesity', COUNT(*) 
        FROM heart_attack
        WHERE Obesity = 1 AND Heart_Attack_Risk = 1
UNION ALL
SELECT 'Diabetes', COUNT(*) 
		FROM heart_attack 
        WHERE Diabetes = 1 AND Heart_Attack_Risk = 1
UNION ALL
SELECT 'Blood_Pressure', COUNT(*) 
		FROM heart_attack 
        WHERE Blood_Pressure > 140 AND Heart_Attack_Risk = 1
UNION ALL
SELECT 'Cholesterol', COUNT(*) 
        FROM heart_attack 
        WHERE Cholesterol > 200 AND Heart_Attack_Risk = 1;

/* Expected Insights:
   - Ranks risk factors by frequency
   - Identifies primary targets for prevention programs */
   
-- Query 2.3: Multiple Risk Factor Combinations

-- Question: What are the most frequent combinations of risk factors?
-- Business Impact: Reveals compound risk patterns requiring comprehensive intervention

SELECT 
    Smoking, 
    Obesity, 
    Diabetes, 
    Stress_Level, 
    COUNT(*) AS frequency,
    ROUND((COUNT(*) * 100.0) / (SELECT COUNT(*) FROM heart_attack WHERE Heart_Attack_Risk = 1), 2) AS percentage
FROM heart_attack
WHERE Heart_Attack_Risk = 1
GROUP BY Smoking, Obesity, Diabetes, Stress_Level
ORDER BY frequency DESC
LIMIT 10;

/* Expected Insights:
   - Shows most dangerous risk factor combinations
   - Enables holistic treatment approaches */

-- Query 2.4: Countries with Multiple Risk Factors

-- Question: Which countries have highest percentage of patients with 3+ risk factors?
-- Business Impact: Identifies regions with most complex health challenges
SELECT 
    Country,
    COUNT(*) AS total_high_risk_patients,
    SUM(CASE 
        WHEN (Smoking + Obesity + Diabetes + 
              CASE WHEN Blood_Pressure > 140 THEN 1 ELSE 0 END + 
              CASE WHEN Cholesterol > 200 THEN 1 ELSE 0 END) >= 3 
        THEN 1 ELSE 0 
    END) AS patients_with_3plus_factors,
    ROUND(
        (SUM(CASE 
          WHEN (Smoking + Obesity + Diabetes + 
                CASE WHEN Blood_Pressure > 140 THEN 1 ELSE 0 END + 
                CASE WHEN Cholesterol > 200 THEN 1 ELSE 0 END) >= 3 
          THEN 1 ELSE 0 
        END) * 100.0) / COUNT(*), 2
    ) AS percentage_3plus_factors
FROM heart_attack
WHERE Heart_Attack_Risk = 1
GROUP BY Country
HAVING COUNT(*) >= 10
ORDER BY percentage_3plus_factors DESC
LIMIT 10;

/* Expected Insights:
   - Highlights countries with severe multi-risk profiles
   - Supports international health resource planning */

-- Query 3.1: Stress Level Impact

-- Question: How does stress level correlate with heart attack risk?
-- Business Impact: Justifies mental health intervention programs

SELECT 
    Stress_Level, 
    COUNT(*) AS risk_cases,
    ROUND((COUNT(*) * 100.0) / (SELECT COUNT(*) FROM heart_attack WHERE Heart_Attack_Risk = 1), 2) AS percentage
FROM heart_attacK
WHERE Heart_Attack_Risk = 1
GROUP BY Stress_Level
ORDER BY risk_cases DESC;

/* Expected Insights:
   - Shows stress-heart disease correlation
   - Supports workplace wellness programs */
   
-- Query 4.1: Age Group Triglyceride Comparison

-- Question: Which age group shows the highest average triglyceride levels?
-- Business Impact: Targets age-specific lipid management programs
SELECT 
    Age, 
    ROUND(AVG(Triglycerides), 2) AS avg_triglycerides,
    COUNT(*) AS patient_count,
    COUNT(CASE WHEN Triglycerides > 150 THEN 1 END) AS high_triglyceride_count
FROM heart_attack
GROUP BY Age
ORDER BY avg_triglycerides DESC;

/* Expected Insights:
   - Shows age-related lipid profile changes
   - Enables preventive screening schedules */
   
                                                    /*   END OF ANALYSIS