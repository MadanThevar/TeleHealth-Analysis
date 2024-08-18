<div align="center">
  <h1> 🏥 Tele-Health Data Analytics Project </h1>
</div>

## 🚀 Overview and Purpose

The **Tele-Health Data Analytics** project dives deep into the analysis of telehealth services using state-of-the-art tools like Python 🐍, PostgreSQL 🐘, Power BI 📊, and ERD Builders 🛠️. This project is designed to extract actionable insights from telehealth service data, helping healthcare providers optimize service delivery, enhance patient satisfaction, and make informed, data-driven decisions. Through this analysis, we emphasize the critical role of data in transforming healthcare delivery and improving patient outcomes. 

## 🔍 Key Findings

- **📈 Service Utilization Patterns**: The analysis identifies peak usage times and the most frequently used telehealth services, offering insights into demand patterns.
- **😊 Patient Satisfaction**: We discovered key factors that influence patient satisfaction, providing opportunities for targeted improvements.
- **💸 Cost Analysis**: The project offers a detailed breakdown of healthcare costs by service type and insurance coverage, allowing for a deeper understanding of financial trends.
- **🔄 Follow-Up Trends**: We explored how follow-up requirements impact healthcare costs and patient satisfaction, offering insights into care continuity.
- **🧠 Frequent Visits**: Mental health issues were the most common diagnoses leading to frequent telehealth visits, highlighting the importance of accessible mental health services.

## 📂 About the Dataset

- **📥 Source**: The dataset is sourced from well-known telehealth providers, including Teladoc Health and Amwell, with additional data web-scraped from platforms like SourceTelehealth and RemoteHealth.
- **📝 Content**: The dataset includes fields such as `ServiceType`, `PatientID`, `SatisfactionScore`, `HealthcareCost`, and `FollowUpRequired`.
- **🔐 Modification**: To ensure privacy, fictional IDs were created while maintaining the authenticity of the other data fields.
- **🧹 Data Cleaning**: Python was utilized for data cleaning, including the removal of duplicates and ensuring data integrity, to provide reliable insights.

## 🗄️ SQL Queries Using PostgreSQL


1. **👨‍⚕️ How many telehealth visits were conducted by gender?**
   ```sql
   SELECT Gender, COUNT(*) AS VisitCount
   FROM TelehealthServicesUsage
   GROUP BY Gender;

**Output:**

<img width="437" alt="Screenshot 2024-08-17 at 22 19 34" src="https://github.com/user-attachments/assets/70acaf20-32b3-4083-a1df-95d484173d1a">


2. **🔢 What is the average satisfaction score for each service type?**
   ```sql
   SELECT ServiceType, ROUND(AVG(SatisfactionScore), 2) AS AverageSatisfaction
   FROM TelehealthServicesUsage
   GROUP BY ServiceType;

**Output:**

<img width="437" alt="Screenshot 2024-08-17 at 22 22 27" src="https://github.com/user-attachments/assets/16668312-fcd1-435e-b7a9-9ff955532a3c">


3. **💸 What is the total healthcare cost for each type of insurance?**
   ```sql
   SELECT InsuranceType, TO_CHAR(SUM(HealthcareCost), 'FM$999,999,999.00') AS TotalCost
   FROM TelehealthServicesUsage
   GROUP BY InsuranceType;

**Output:**

<img width="437" alt="Screenshot 2024-08-17 at 22 25 20" src="https://github.com/user-attachments/assets/e4dd0056-904e-47ea-8b8a-c0dee6d2c97f">



 4. **⏳ What is the average duration of visits for each gender and socioeconomic status (for satisfaction scores > 3)?**
    ```sql
    SELECT Gender, SocioeconomicStatus, ROUND(AVG(DurationOfVisit), 2) AS AverageDuration
    FROM TelehealthServicesUsage
    WHERE SatisfactionScore > 3
    GROUP BY Gender, SocioeconomicStatus
    ORDER BY Gender, SocioeconomicStatus;
   
**Output:**

<img width="624" alt="Screenshot 2024-08-17 at 22 29 54" src="https://github.com/user-attachments/assets/c5dbfff0-f161-4d22-af28-7e99930e05c3">



5. **🩺 How many patients had technical issues during their telehealth visits, grouped by primary diagnosis and insurance type?**
   ```sql
   SELECT PrimaryDiagnosis, InsuranceType, COUNT(*) AS NumPatientsWithTechnicalIssues
   FROM TelehealthServicesUsage
   WHERE TechnicalIssues = 'Yes'
   GROUP BY PrimaryDiagnosis, InsuranceType
   ORDER BY PrimaryDiagnosis, InsuranceType;

**Output:**

<img width="624" alt="Screenshot 2024-08-17 at 22 31 57" src="https://github.com/user-attachments/assets/891676f2-61b5-4762-8dda-ba358d984d3e">



6. **💰 What is the total healthcare cost and the number of follow-up visits for each ethnicity, specifically for patients with 'Medicaid' insurance?**
    ```sql
    SELECT Ethnicity, TO_CHAR(SUM(HealthcareCost), 'FM$999,999,999.00') AS TotalHealthcareCost, COUNT(*) AS FollowUpVisits
    FROM TelehealthServicesUsage
    WHERE InsuranceType = 'Medicaid' AND FollowUpRequired = 'Yes'
    GROUP BY Ethnicity
    ORDER BY TotalHealthcareCost DESC;

**Output:**

<img width="626" alt="Screenshot 2024-08-17 at 22 36 15" src="https://github.com/user-attachments/assets/2d918360-1991-4fde-9330-4e648a69daa0">


7. **📊 What is the average satisfaction score and total number of visits for each combination of primary diagnosis and service type?**
   ```sql
   SELECT PrimaryDiagnosis, ServiceType,
       ROUND(AVG(SatisfactionScore), 2) AS AverageSatisfactionScore,
       COUNT(*) AS TotalNumberOfVisits
   FROM TelehealthServicesUsage
   GROUP BY PrimaryDiagnosis, ServiceType
   ORDER BY PrimaryDiagnosis, ServiceType;

**Output:**

<img width="631" alt="Screenshot 2024-08-17 at 22 55 36" src="https://github.com/user-attachments/assets/a10f76dc-2bdc-49a0-b43c-baa027895890">

8. **🔍 For each primary diagnosis, determine the average healthcare cost and satisfaction score for visits that required follow-up compared to those that did not?**
   ```sql
   SELECT PrimaryDiagnosis,
       TO_CHAR(AVG(CASE WHEN FollowUpRequired = 'Yes' THEN CAST(HealthcareCost AS numeric) ELSE NULL END), 'FM$999,999,999.00') AS AvgCostWithFollowUp,
       TO_CHAR(AVG(CASE WHEN FollowUpRequired = 'No' THEN CAST(HealthcareCost AS numeric) ELSE NULL END), 'FM$999,999,999.00') AS AvgCostWithoutFollowUp,
       ROUND(AVG(CASE WHEN FollowUpRequired = 'Yes' THEN SatisfactionScore ELSE NULL END), 2) AS AvgSatisfactionWithFollowUp,
       ROUND(AVG(CASE WHEN FollowUpRequired = 'No' THEN SatisfactionScore ELSE NULL END), 2) AS AvgSatisfactionWithoutFollowUp
   FROM TelehealthServicesUsage
   GROUP BY PrimaryDiagnosis
   ORDER BY PrimaryDiagnosis;

**Output:**

<img width="671" alt="Screenshot 2024-08-17 at 23 02 36" src="https://github.com/user-attachments/assets/9ca4d6db-d1cb-4dec-98b3-eeda5d6afe7b">



9. **🏥 Determine the top 3 primary diagnoses based on total healthcare costs, and for each, provide the average satisfaction score and the number of visits?**
   ```sql
   WITH DiagnosisStats AS (
    SELECT PrimaryDiagnosis,
           SUM(CAST(HealthcareCost AS numeric)) AS TotalHealthcareCost,
           AVG(SatisfactionScore) AS AvgSatisfactionScore,
           COUNT(*) AS VisitCount
    FROM TelehealthServicesUsage
    GROUP BY PrimaryDiagnosis
   )
   SELECT PrimaryDiagnosis,
       TO_CHAR(TotalHealthcareCost, 'FM$999,999,999.00') AS TotalHealthcareCost,
       ROUND(AvgSatisfactionScore, 2) AS AvgSatisfactionScore,
       VisitCount
   FROM DiagnosisStats
   ORDER BY TotalHealthcareCost DESC
   LIMIT 3;

**Output:**

<img width="623" alt="Screenshot 2024-08-17 at 23 08 43" src="https://github.com/user-attachments/assets/0dbc1016-cb56-4eb2-9e3c-86f04ac6e480">

   10. **💻 Calculate the average healthcare cost and average satisfaction score for each telehealth platform, and identify the telehealth platform with the highest average satisfaction score?**
       ```sql
       WITH PlatformStats AS (
       SELECT TelehealthPlatform,
           AVG(CAST(HealthcareCost AS numeric)) AS AvgHealthcareCost,
           AVG(SatisfactionScore) AS AvgSatisfactionScore
       FROM TelehealthServicesUsage
       GROUP BY TelehealthPlatform
       )
       SELECT TelehealthPlatform,
       TO_CHAR(AvgHealthcareCost, 'FM$999,999,999.00') AS AvgHealthcareCost,
       ROUND(AvgSatisfactionScore, 2) AS AvgSatisfactionScore
       FROM PlatformStats
       ORDER BY AvgSatisfactionScore DESC
       LIMIT 1;


**Output:**

<img width="622" alt="Screenshot 2024-08-17 at 23 17 35" src="https://github.com/user-attachments/assets/9b47021b-33b1-4998-9a98-1192a25bc02a">


   11. **🔍 Determine the top 3 primary diagnoses with the highest average healthcare costs for patients aged 60 and above, and calculate the average satisfaction score and the percentage of 
       visits that required follow-up for each diagnosis?**
       ```sql
       WITH AgeFilteredData AS (
       SELECT PrimaryDiagnosis,
           SatisfactionScore,
           CAST(HealthcareCost AS numeric) AS HealthcareCost,
           FollowUpRequired,
           Age,
           PatientID
       FROM TelehealthServicesUsage
       WHERE Age >= 60
       ),
       DiagnosisStats AS (
       SELECT PrimaryDiagnosis,
           AVG(HealthcareCost) AS AvgHealthcareCost,
           AVG(SatisfactionScore) AS AvgSatisfactionScore,
           SUM(CASE WHEN FollowUpRequired = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS FollowUpVisitPercentage
       FROM AgeFilteredData
       GROUP BY PrimaryDiagnosis
       ),
       RankedDiagnoses AS (
       SELECT PrimaryDiagnosis,
           AvgHealthcareCost,
           AvgSatisfactionScore,
           FollowUpVisitPercentage,
           RANK() OVER (ORDER BY AvgHealthcareCost DESC) AS Rank
       FROM DiagnosisStats
       )
       SELECT PrimaryDiagnosis,
       TO_CHAR(AvgHealthcareCost, 'FM$999,999,999.00') AS AvgHealthcareCost,
       ROUND(AvgSatisfactionScore, 2) AS AvgSatisfactionScore,
       ROUND(FollowUpVisitPercentage, 2) AS FollowUpVisitPercentage
       FROM RankedDiagnoses
       WHERE Rank <= 3
       ORDER BY AvgHealthcareCost DESC;

**Output:**

<img width="625" alt="Screenshot 2024-08-17 at 23 20 59" src="https://github.com/user-attachments/assets/03c0d0a0-c03b-434f-933a-447c1eb369b8">


## 🗄️ ERD Diagram for Tele-Health Data Analytics

### 📝 Overview

The **Entity-Relationship Diagram (ERD)** for the Tele-Health Data Analytics project is a visual representation of the key entities involved in telehealth services and their relationships. This ERD was created using **dbdiagram.io** 🛠️ and serves as the foundation for understanding the structure of the telehealth data.

### 📊 Key Entities

1. **🧑‍⚕️ Patients**: 
   - Contains patient information such as ID, age, gender, ethnicity, and socioeconomic status.

2. **🏥 Visits**: 
   - Records each telehealth visit, including details like patient ID, visit date, service type, visit duration, satisfaction score, technical issues, follow-up needs, healthcare cost, insurance details, and diagnosis.

3. **🩺 Diagnoses**: 
   - Logs the primary diagnosis associated with each visit.

4. **💻 Telehealth Platforms**: 
   - Tracks the platforms (e.g., Teladoc, Amwell) used to deliver telehealth services.

5. **🛡️ Insurance**: 
   - Captures information about the insurance coverage for telehealth services.

6. **⚙️ Technical Issues**: 
   - Logs any technical difficulties encountered during the telehealth visit, including descriptions of the issues.

### 🔗 Key Relationships

- **👥 Patients ↔ Visits**: 
  - Each patient can have multiple visits, with each visit linked to a specific patient.

- **🔄 Visits ↔ Diagnoses**: 
  - Every visit is associated with a primary diagnosis.

- **💻 Visits ↔ Telehealth Platforms**: 
  - Each visit takes place on a particular telehealth platform.

- **🛡️ Visits ↔ Insurance**: 
  - Each visit is covered by a specific type of insurance.

- **⚙️ Visits ↔ Technical Issues**: 
  - Any technical issues during the visit are recorded and linked to the visit.

### 🎯 Purpose of the ERD

The ERD is designed to:
- **🔍 Visualize Relationships**: Clearly illustrate the connections between patients, visits, diagnoses, platforms, insurance, and technical issues.
- **📈 Facilitate Data Analysis**: Enable efficient querying and analysis of telehealth data, such as service utilization patterns, patient satisfaction, and platform performance.
- **🚀 Optimize Data Management**: Assist healthcare providers in managing telehealth data, allowing for improved service delivery and data-driven decision-making.

This diagram is crucial for the project's data management strategy, making it easier for healthcare providers to analyze trends, improve patient outcomes, and optimize telehealth services. The ERD was constructed using **dbdiagram.io** 🛠️, a powerful tool for creating and visualizing database structures.

### 📝 ERD Diagram 


<img width="625" alt="Screenshot 2024-08-17 at 23 35 25" src="https://github.com/user-attachments/assets/6e0fa70c-8a48-41d7-b26b-715f21cfb89f">






