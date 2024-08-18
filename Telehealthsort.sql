Basic Beginner Questions 

Question 1: How many telehealth visits were conducted by gender?

SELECT Gender, COUNT(*) AS VisitCount
FROM TelehealthServicesUsage
GROUP BY Gender;

Question 2: What is the average satisfaction score for each service type?

SELECT ServiceType, ROUND(AVG(SatisfactionScore), 2) AS AverageSatisfaction
FROM TelehealthServicesUsage
GROUP BY ServiceType;

Question 3: What is the total healthcare cost for each type of insurance?

SELECT InsuranceType, 
       to_char(SUM(HealthcareCost), 'FM$999,999,999.00') AS TotalCost
FROM TelehealthServicesUsage
GROUP BY InsuranceType;

## Intermediate Level Questionnaire 

Question - 1: What is the average duration of visits for each gender and socioeconomic status, 
only for visits where the satisfaction score is greater than 3?

SELECT Gender, SocioeconomicStatus, ROUND(AVG(DurationOfVisit), 2) AS AverageDuration
FROM TelehealthServicesUsage
WHERE SatisfactionScore > 3
GROUP BY Gender, SocioeconomicStatus
ORDER BY Gender, SocioeconomicStatus;

Question - 2: How many patients had technical issues during their telehealth visits, grouped by primary diagnosis and insurance type?

SELECT 
    PrimaryDiagnosis,
    InsuranceType,
    COUNT(*) AS NumPatientsWithTechnicalIssues
FROM 
    TelehealthServicesUsage
WHERE 
    TechnicalIssues = 'Yes'
GROUP BY 
    PrimaryDiagnosis,
    InsuranceType
ORDER BY 
    PrimaryDiagnosis,
    InsuranceType;

Question - 3) What is the total healthcare cost and the number of follow-up visits for each ethnicity, only for patients with 'Medicaid' insurance?

SELECT Ethnicity, 
       to_char(SUM(HealthcareCost), 'FM$999,999,999.00') AS TotalHealthcareCost, 
       COUNT(*) AS FollowUpVisits
FROM TelehealthServicesUsage
WHERE InsuranceType = 'Medicaid' AND FollowUpRequired = 'Yes'
GROUP BY Ethnicity
ORDER BY TotalHealthcareCost DESC;

Question - 4) What is the average satisfaction score and total number of visits for each combination of primary diagnosis and service type?
	
SELECT PrimaryDiagnosis, ServiceType, 
       ROUND(AVG(SatisfactionScore), 2) AS AverageSatisfactionScore, 
       COUNT(*) AS TotalNumberOfVisits
FROM TelehealthServicesUsage
GROUP BY PrimaryDiagnosis, ServiceType
ORDER BY PrimaryDiagnosis, ServiceType;

Question -5 ) For each primary diagnosis, determine the average healthcare cost and satisfaction score for visits that required follow-up compared to those that did not?

SELECT 
    PrimaryDiagnosis,
    TO_CHAR(AVG(CASE WHEN FollowUpRequired = 'Yes' THEN CAST(HealthcareCost AS numeric) ELSE NULL END), 'FM$999,999,999.00') AS AvgCostWithFollowUp,
    TO_CHAR(AVG(CASE WHEN FollowUpRequired = 'No' THEN CAST(HealthcareCost AS numeric) ELSE NULL END), 'FM$999,999,999.00') AS AvgCostWithoutFollowUp,
    ROUND(AVG(CASE WHEN FollowUpRequired = 'Yes' THEN SatisfactionScore ELSE NULL END), 2) AS AvgSatisfactionWithFollowUp,
    ROUND(AVG(CASE WHEN FollowUpRequired = 'No' THEN SatisfactionScore ELSE NULL END), 2) AS AvgSatisfactionWithoutFollowUp
FROM 
    TelehealthServicesUsage
GROUP BY 
    PrimaryDiagnosis
ORDER BY 
    PrimaryDiagnosis;
 
## Advanced Questionnaire 

Question - 1) Determine the top 3 primary diagnoses based on total healthcare costs, and for each, provide the average satisfaction score and the number of visits?

WITH DiagnosisStats AS (
    SELECT 
        PrimaryDiagnosis,
        SUM(CAST(HealthcareCost AS numeric)) AS TotalHealthcareCost,
        AVG(SatisfactionScore) AS AvgSatisfactionScore,
        COUNT(*) AS VisitCount
    FROM 
        TelehealthServicesUsage
    GROUP BY 
        PrimaryDiagnosis
)
SELECT 
    PrimaryDiagnosis,
    TO_CHAR(TotalHealthcareCost, 'FM$999,999,999.00') AS TotalHealthcareCost,
    ROUND(AvgSatisfactionScore, 2) AS AvgSatisfactionScore,
    VisitCount
FROM 
    DiagnosisStats
ORDER BY 
    TotalHealthcareCost DESC
LIMIT 3;

Question-2) Calculate the average healthcare cost and average satisfaction score for each telehealth platform, and identify the telehealth platform with the highest average satisfaction score?

WITH PlatformStats AS (
    SELECT 
        TelehealthPlatform,
        AVG(CAST(HealthcareCost AS numeric)) AS AvgHealthcareCost,
        AVG(SatisfactionScore) AS AvgSatisfactionScore
    FROM 
        TelehealthServicesUsage
    GROUP BY 
        TelehealthPlatform
)
SELECT 
    TelehealthPlatform,
    TO_CHAR(AvgHealthcareCost, 'FM$999,999,999.00') AS AvgHealthcareCost,
    ROUND(AvgSatisfactionScore, 2) AS AvgSatisfactionScore
FROM 
    PlatformStats
ORDER BY 
    AvgSatisfactionScore DESC
LIMIT 1;

Question-3)Determine the top 3 primary diagnoses with the highest average healthcare costs for patients aged 60 and above, and calculate the average satisfaction score and the percentage of visits that required follow-up for each diagnosis?


WITH AgeFilteredData AS (
    SELECT 
        PrimaryDiagnosis,
        SatisfactionScore,
        CAST(HealthcareCost AS numeric) AS HealthcareCost,
        FollowUpRequired,
        Age,
        PatientID
    FROM 
        TelehealthServicesUsage
    WHERE 
        Age >= 60
),
DiagnosisStats AS (
    SELECT 
        PrimaryDiagnosis,
        AVG(HealthcareCost) AS AvgHealthcareCost,
        AVG(SatisfactionScore) AS AvgSatisfactionScore,
        SUM(CASE WHEN FollowUpRequired = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS FollowUpVisitPercentage
    FROM 
        AgeFilteredData
    GROUP BY 
        PrimaryDiagnosis
),
RankedDiagnoses AS (
    SELECT 
        PrimaryDiagnosis,
        AvgHealthcareCost,
        AvgSatisfactionScore,
        FollowUpVisitPercentage,
        RANK() OVER (ORDER BY AvgHealthcareCost DESC) AS Rank
    FROM 
        DiagnosisStats
)
SELECT 
    PrimaryDiagnosis,
    TO_CHAR(AvgHealthcareCost, 'FM$999,999,999.00') AS AvgHealthcareCost,
    ROUND(AvgSatisfactionScore, 2) AS AvgSatisfactionScore,
    ROUND(FollowUpVisitPercentage, 2) AS FollowUpVisitPercentage
FROM 
    RankedDiagnoses
WHERE 
    Rank <= 3
ORDER BY 
    AvgHealthcareCost DESC;




