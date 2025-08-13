/*Transform Bank A seed .csv to Bank A fact table */

{{ config(materialized='incremental') }}

with base as
(
SELECT
    CAST(strptime("Transaction Date", '%m/%d/%Y') AS date) AS formatted_dt,
    Type,
    Description,
    Amount
FROM {{ ref('BankA_seed') }} 
    

)
SELECT 
    {{ dbt_utils.generate_surrogate_key(['Description', 'formatted_dt']) }} AS trans_ID,
     formatted_dt as trans_dt,
    'Chase' as company,
    CASE
        WHEN Type in ('Fee', 'Cash Advance', 'Adjustment') THEN 'Sale'
        ELSE Type
    END as trans_type,
    {{ clean_merchant_descriptor('Description')}} AS merchant_descriptor,
    CAST(Amount as DECIMAL(10,2)) * -1 as trans_amt

FROM base
    {% if is_incremental() %}
    WHERE formatted_dt > (SELECT MAX(trans_dt) FROM {{ this }})
    {% endif %}

    