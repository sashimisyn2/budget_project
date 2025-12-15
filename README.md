# Budget Tracker

This project documents the dbt jobs to aggregate your credit card and bank statements into a payment data mart for analyses with a jupyter notebook. This project uses all open-source code and is aimed at people have a basic knowledge of SQL for transformation and beginner python for analyses. 

## Motivation
I created this project because I needed to aggregate and analyze my spend. However, I did not want to expose my data to a third party company and I didn't find any of the budget apps that compelling for the prices charged.

## Installation
This project requires the following (including respective package manager to install):

- DBT for data transformation (pip)
- DuckDB for data warehouse and storage (pip)
- Jupyter notebook to create a final analysis (homebrew, conda)
- An integrated development editor (such as Visual Code Studio) to edit and manage files

## Usage
The project is comprised of the following stages:
1. Upload credit card and debit card .csv statements as seed files (dbt & DuckDB)
2. Transform .csv statements into staging tables (dbt & DuckDB >> "01_upload_bank")
3. Apply a spend dimension table that categorizes spend and merchant name >> this will depend on where you conduct your spend (dbt & DuckDB >> "02_upload_dim_spend")
4. Create final spend fact table (dbt & DuckDB >> "03_fct_spend")
5. Use jupyter notebook as final layer on top of fact table for analysis (jupyter notebook >> "analyses >> Spend_Tracker_vBudget.ipynb")

## Data
The data .csv files are mock datasets. All banks should be able to provide .csv files based off specific time ranges. 
- The first need is minor data transformation in order to ensure the same datatype and format. 
- The second need is to create a dimension file that assigns an aggregated merchant name based off the various merchant descriptor values and categorizes the line item spend (Side note: the category assignment can also be based off merchant descriptor, but I decided to address that at the seed file for better granularity).

## Budget Tracker Overview
One of the main challenges with budgeting is comparing the rate that one spends cash with the rate (actual spend) that one *should* be spending (budget). 
- Being over budget means spending more than one should (and therefore, consuming too much utility)
- Being under budget means spending less than one should (but giving up on unused utility)

Therefore, the notebook has 6 charts to answer 6 specific questions: 
1. Cumulative Spend Pct vs Budget Benchmark YTD (%) >> Am I within budget? 
2. $ Budget Spent vs Benchmark (%) >> For which months was I over or under budget? (Most likely due to one-time big purchases)
3. Cumulative Budget Delta ($) >> Cumulatively, how much remaining budget do I have each month? (Informs whether to spend more or less)
4. Monthly Spend ($) >> How much did I spend every month? 
5. Category Spend YTD ($) >> What are my top categorical spends? 
6. Spend (%) by Category >> Which categories was I over or under budget? 


