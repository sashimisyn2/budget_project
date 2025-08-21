{% macro clean_merchant_descriptor(input_column) %}
    TRIM(REGEXP_REPLACE({{ input_column }}, '\s+', ' ', 'g'))
{% endmacro %}
