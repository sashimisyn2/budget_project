/*Budget_Project: Assign scrubbed merchant name and category flag for final spend dimension table */

{{ config(materialized='incremental') }}


SELECT
    dim_dt,
    REGEXP_REPLACE(merchant_descriptor, '\s+', ' ', 'g') AS merchant_descriptor,
    category_flag as category_flag,
    CASE
    WHEN POSITION('TST' IN merchant_descriptor) > 0
         OR POSITION('SQ' IN merchant_descriptor) > 0
        THEN 'Retail - Food Merchant'

    WHEN POSITION('ALDI' IN merchant_descriptor) > 0
        THEN 'Aldi'

    WHEN POSITION('AMAZON' IN merchant_descriptor) > 0
        THEN 'Amazon'

    WHEN POSITION('PAYMENT' IN merchant_descriptor) > 0
        THEN 'Payment'

    WHEN POSITION('YMCA' IN merchant_descriptor) > 0
         OR POSITION('DAYCARE' IN merchant_descriptor) > 0
        THEN 'Childcare'

    WHEN POSITION('BLUE CROSS' IN merchant_descriptor) > 0
        THEN 'Blue Cross Blue Shield'

    WHEN POSITION('CHEVRON' IN merchant_descriptor) > 0
        THEN 'Chevron'

    WHEN POSITION('CHILDREN' IN merchant_descriptor) > 0
        THEN 'Children''s Place'

    WHEN POSITION('COSTCO' IN merchant_descriptor) > 0
        THEN 'Costco'

    WHEN POSITION('GEICO' IN merchant_descriptor) > 0
        THEN 'GEICO'

    WHEN POSITION('HOME DEPOT' IN merchant_descriptor) > 0
        THEN 'The Home Depot'

    WHEN POSITION('ICELANDA' IN merchant_descriptor) > 0
        THEN 'Icelandic Air'

    WHEN POSITION('JETBLUE' IN merchant_descriptor) > 0
        THEN 'JetBlue'

    WHEN POSITION('KROGER' IN merchant_descriptor) > 0
        THEN 'Kroger'

    WHEN POSITION('NIJIYA' IN merchant_descriptor) > 0
        THEN 'Nijiya'

    WHEN POSITION('Pets' IN merchant_descriptor) > 0
        THEN 'Retail - Pets'

    WHEN POSITION('PROGRESSIVE' IN merchant_descriptor) > 0
        THEN 'Progressive'

    WHEN POSITION('PTA' IN merchant_descriptor) > 0
        THEN 'PTA'

    WHEN POSITION('SAFEWAY' IN merchant_descriptor) > 0
        THEN 'Safeway'

    WHEN POSITION('SHELL' IN merchant_descriptor) > 0
        THEN 'Shell Gas'

    WHEN POSITION('SHOPIFY' IN merchant_descriptor) > 0
        THEN 'Retail - Small Merchant'

    WHEN POSITION('SPROUTS' IN merchant_descriptor) > 0
        THEN 'Sprouts'

    WHEN POSITION('SUNCO' IN merchant_descriptor) > 0
        THEN 'Sunco'

    WHEN POSITION('TARGET' IN merchant_descriptor) > 0
        THEN 'Target'

    WHEN POSITION('TRADER' IN merchant_descriptor) > 0
        THEN 'Trader Joe''s'

    WHEN POSITION('UTILITY' IN merchant_descriptor) > 0
        THEN 'Utilities'

    WHEN POSITION('WALMART' IN merchant_descriptor) > 0
        THEN 'Walmart'

    WHEN POSITION('WSJ' IN merchant_descriptor) > 0
        THEN 'Wall Street Journal'

    WHEN POSITION('WHOLE FOODS' IN merchant_descriptor) > 0
         OR POSITION('WHOLEFDS' IN merchant_descriptor) > 0
        THEN 'Whole Foods'

    WHEN POSITION('United' IN merchant_descriptor) > 0
        THEN 'United Air'

    ELSE 'Needs merchant name'
END AS merchant_name

        
FROM {{ ref('spend_dim_template') }}
      {% if is_incremental() %} 
      WHERE dim_dt > (SELECT MAX(dim_dt) FROM {{ this }})
      {% endif %}




