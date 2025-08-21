/*Final Fact Table */

{{ config(materialized='table') }}

with base as(
SELECT 
    a.*,
    CONCAT(Year(trans_dt), ' ', Month(trans_dt)) as year_month
    FROM {{ ref('stg_BankA') }} as a 
union all
SELECT 
    b.*,
    CONCAT(Year(trans_dt), ' ', Month(trans_dt)) as year_month
    FROM {{ ref('stg_BankB') }} as b
)


SELECT
 base.*,
 SDR.category_flag,
 SDR.merchant_name,
  
FROM base
    LEFT JOIN {{ ref('dim_spend')}} as SDR on base.merchant_descriptor = SDR.merchant_descriptor
        {% if is_incremental() %}
        WHERE trans_dt > (SELECT MAX(trans_dt) FROM {{ this }})
        {% endif %}