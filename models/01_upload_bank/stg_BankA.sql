/*Transform Bank A seed .csv to Bank A fact table */

{{ config(materialized='table') }}

with base as
(
SELECT
    CAST(strptime("Transaction Date", '%m/%d/%Y') AS date) AS formatted_dt,
    Type,
    Description,
    Amount
FROM {{ ref('seed_BankA') }} 
    

)
SELECT 
    {{ dbt_utils.generate_surrogate_key(['Description', 'formatted_dt']) }} AS trans_ID,
     formatted_dt as trans_dt,
     YEAR(formatted_dt) as yr,
     MONTH(formatted_dt) AS mnth,
    'BankA' as company,
    CASE
        WHEN Type in ('Fee', 'Cash Advance', 'Adjustment') THEN 'Sale'
        ELSE Type
    END as trans_type,
    {{ clean_merchant_descriptor('Description')}} AS merchant_descriptor,
    CAST(Amount as DECIMAL(10,2)) * -1 as trans_amt

FROM base
    
    