# Loan Default Risk Analysis

## Project Overview
An end-to-end data analysis project focused on analysing historical loan performance and identifying customer segments with higher loan default rates.

The project uses PostgreSQL for data storage and SQL-based analysis, and Power BI for interactive dashboards and visualisation.

## Tools & Technologies
- PostgreSQL
- SQL
- Microsoft Power BI
- DAX
- Microsoft Excel

## Business Questions
1. Which customer segments have the highest historical loan default rates?
2. Which loan applications should be flagged for manual review?
3. How do income, employment length, loan purpose, geography, credit sub-grade and DTI relate to loan performance?

## Dashboard KPIs
- Total Applications
- Default Rate
- Good Loans
- Defaulted Loans

## Analysis Performed
- Default rate by employment length
- Default rate by loan purpose
- Default rate by state
- Default rate by loan sub-grade
- Default rate by debt-to-income band
- Default rate by annual income bracket

## Key Business Insights

1. **Income Risk:** The Below 25K income bracket recorded a 24.63% historical bad-loan rate, compared with 15.91% for the 100K+ bracket.

2. **DTI Risk:** Applications with DTI above 40 recorded a 30.55% bad-loan rate, the highest among the displayed DTI bands.

3. **Employment Risk:** Applications with missing employment-length information showed a 26.91% bad-loan rate.

4. **Loan Purpose Risk:** Small Business loans recorded a 29.71% bad-loan rate among the displayed purposes.

5. **Sub-grade Risk:** G5 recorded a 53.60% bad-loan rate among the displayed sub-grades.

6. **Geographical Risk:** Mississippi recorded a 26.06% bad-loan rate among the displayed states.

## Manual Review Logic

Applications are flagged for preliminary manual review when any of these conditions apply:
- Debt-to-income ratio is above 30.
- Loan sub-grade begins with D, E, F or G.
- Loan status is Late (31-120 days) or In Grace Period.

This is an illustrative rule-based screening approach, not a validated credit-scoring or predictive model.

## Important Limitations
- The analysis describes historical loan outcomes, not future default probabilities.
- The insights above refer to categories visible in the dashboard screenshots; they may not represent the highest values across every category.
- The manual review rules require further validation before any real credit decision.

## Project Status
-  PostgreSQL data setup
-  Power BI dashboard
-  KPI measures and DAX calculations
-  Customer risk segmentation
-  Preliminary manual review dashboard
-    Initial business insights
-    SQL documentation
-  Dashboard screenshots

  ## Dashboard Report

[View / Download Power BI Dashboard (PDF)](./loan-default-risk-analysis.pdf)


## Dashboard Preview

### Main Dashboard
![Loan Default Risk Dashboard](./Screenshot%202026-11-25%20160150.png)

### Manual Review Dashboard
![Manual Review Dashboard](./Screenshot%202026-11-25%20183731.png)

## SQL Analysis

[View SQL Queries](./SQL/loan_analysis.sql)

