/*Final Fact Table */

{{ config(materialized='incremental') }}

with base as(
SELECT 
    F.*,
    CONCAT(Year(trans_dt), ' ', Month(trans_dt)) as year_month
    FROM {{ ref('fct_fidelity') }} as F 
union all
SELECT 
    C.*,
    CONCAT(Year(trans_dt), ' ', Month(trans_dt)) as year_month
    FROM {{ ref('fct_chase') }} as C
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