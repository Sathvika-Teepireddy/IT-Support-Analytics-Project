# IT-Support-Analytics-Project

**IT Support Ticket Analytics — Security Breach Prediction**

End-to-end data analytics project covering synthetic data generation, SQL analysis, Python EDA, Machine Learning classification, and Power BI dashboarding — built to simulate real-world IT security operations.

📌 Project Overview
In modern IT environments, thousands of support tickets are raised daily. Not all of them are equal — some indicate potential security breaches (SLA violations, malware incidents, unauthorized access). This project builds a complete analytics pipeline to:

 - Generate realistic IT support ticket data with business logic
 - Analyze breach patterns across categories, priorities, and time
 - Predict future breaches using a Random Forest ML model
 - Visualize insights through Power BI dashboards

 🎯 Business Problem

"Which IT support tickets are most likely to become security breaches — and can we predict them before they escalate?"

Real IT operations teams face this challenge every day. By identifying high-risk patterns early, organizations can prioritize response, allocate resources efficiently, and reduce mean time to resolution (MTTR).

 - Dataset : Breach distribution: 276 breaches out of 1,000 tickets (~27.6%)
 - Business Questions - sql queries

Q1 How many tickets per category?
key findings:- Even distribution across 6 categories

Q2 Which category has the most breaches?
key findings:-Malware Alert has the highest breach volume

Q3 What is the breach rate per category?
key findings:-Malware Alert ~48%, Phishing Email ~41%

Q4 Are after-hours tickets more dangerous?
key findings:-After-hours breach rate: 30% vs 25% daytime

Q5 Avg resolution time by after-hours status
key findings:-After-hours tickets take slightly longer

Q6 Which priority has the most breaches?
key findings:-Critical and High combined = 60%+ of breaches

Q7 Do repeated issues lead to more breaches?
key findings:-Repeated issues show fewer breaches than new ones

Q8 Which 3 months had the highest breaches?
key findings:-Identified top-3 months for targeted review

- 📈 Exploratory Data Analysis (EDA)
Three charts visualize key patterns:
Chart 1 — Breach Rate by Category

Chart 2 — Priority vs After-Hours Heatmap

Chart 3 — Monthly Trend Line

- Machine Learning Model
Algorithm: Random Forest Classifier

                  precision    recall    f1-score
Normal Ticket     ~0.84      ~0.80      ~0.82
Breach            ~0.65      ~0.71      ~0.68

Accuracy: ~77%

Top Breach Predictors (Feature Importance)

resolution_time — longer resolution = higher risk
category_Malware Alert — highest single-category risk
category_Phishing Email — second most dangerous
priority_Critical — escalates breach probability significantly
after_hours — night-time tickets carry extra risk

💡 Key Business Insights

Malware and Phishing tickets are crisis-level — 
nearly 50% of all breaches. These need immediate escalation protocols.
After-hours monitoring is essential — 
tickets raised outside business hours breach at a 30% rate. An on-call or automated alert system for after-hours high-priority tickets is recommended.
Critical + Malware = automatic escalation — 
the ML model confirms that the combination of Critical priority and Malware category is the strongest predictor of breach.
Resolution time is the top ML feature — 
tickets taking longer to resolve are more likely to become breaches. 

