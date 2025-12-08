# Budget Tracker

This project documents the dbt jobs to aggregate your credit card and bank statements into a payment data mart in order to conduct analyses with a jupyter notebook. This project uses all open-source code and is aimed at people have a basic knowledge of SQL for transformation and python for analyses. 

## Motivation
This project was createc because I needed to aggregate and analyze my spend. However, I did not want to expose my data to a third party company and I did not think the price for paid budget apps was worth the tracking features.  

## Installation
This project requires the following (including respective package manager to install):

- DBT for data transformation (pip)
- DuckDB for data warehouse and storage (pip)
- Jupyter notebook to create a final analysis (homebrew, conda)
- An integrated development editor (such as Visual Code Studio) to edit files


## Usage
The project is comprised of the following components:
1. Upload  credit card and debit card .csv statements
2. Transform .csv statements into staging tables
3. Apply a spend dimension table that categorizes spend and merchant name >> this will depend on where you conduct your spend
4. Create final spend fact table
5. Use jupyter notebook as final layer on top of fact table for analysis


