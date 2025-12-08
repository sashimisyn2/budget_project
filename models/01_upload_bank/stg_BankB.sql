/*Transform Bank B seed table for Bank fact */

{{ config(materialized='table') }}

SELECT 
    {{ dbt_utils.generate_surrogate_key(['Name', 'Date']) }} AS trans_ID,
    Date as trans_dt,
    YEAR(Date) as yr,
    MONTH(Date) AS mnth,
    'BankB' as company,
    CASE 
         WHEN Transaction = 'DEBIT' THEN 'Sale'
         WHEN Transaction = 'CREDIT' and Name = 'PAYMENT   THANK YOU' THEN 'Payment'
         WHEN Transaction = 'CREDIT' and Name <> 'PAYMENT   THANK YOU' THEN 'Return'
         ELSE 'Check'
    END
        as trans_type,
    {{ clean_merchant_descriptor('Name')}} AS merchant_descriptor,
    CAST(Amount as DECIMAL(10,2)) * -1 as trans_amt

FROM {{ ref('seed_BankB')}}
    
