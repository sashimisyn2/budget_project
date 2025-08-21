--flag merchant descriptor values that need to be mapped, to be overwritten each month uploaded

{{ config(materialized='table') }}
with base as (

          
    SELECT
        ff.Merchant_Descriptor
    FROM {{ ref('fct_fidelity') }} ff
    UNION ALL
    SELECT
        cf.Merchant_Descriptor
    FROM {{ ref('fct_chase') }} cf
    )

SELECT
    b.Merchant_Descriptor
FROM base as b
LEFT JOIN dim_spend dim
    ON b.Merchant_Descriptor = dim.Merchant_Descriptor
    WHERE dim.Category_flag is null
    OR dim.Merchant_Name is null
