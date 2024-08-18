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

### Beginner Level

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

 ### Intermediate Level

 1. **⏳ What is the average duration of visits for each gender and socioeconomic status (for satisfaction scores > 3)?**
    ```sql
    SELECT Gender, SocioeconomicStatus, ROUND(AVG(DurationOfVisit), 2) AS AverageDuration
    FROM TelehealthServicesUsage
    WHERE SatisfactionScore > 3
    GROUP BY Gender, SocioeconomicStatus
    ORDER BY Gender, SocioeconomicStatus;
   
**Output:**




