{{ config(materialized='ephemeral') }}

WITH source_data AS (
    SELECT
        ALPHABETICCODE AS CURRENCY_CODE,
        CURRENCYNAME AS CURRENCY_NAME,
        LOCATIONS AS LOCATIONS,
        LOAD_TS AS LOAD_TS,
        DECIMALDIGITS AS DECIMAL_DIGITS,
        NUMERICCODE AS NUMERIC_CODE,
        'SEED.ACB_BANK_CURRENCY_ISO' AS RECORD_SOURCE
    FROM {{ source('seeds', 'ACB_BANK_CURRENCY_ISO')}}
),
hashed AS (
    SELECT {{ dbt_utils.generate_surrogate_key(['CURRENCY_CODE']) }} AS CURRENCY_HKEY,
    {{ dbt_utils.generate_surrogate_key(['CURRENCY_CODE', 'CURRENCY_NAME', 'LOCATIONS',
    'DECIMAL_DIGITS', 'NUMERIC_CODE'])}} AS CURRENCY_HDIFF,
    * EXCLUDE LOAD_TS,
    LOAD_TS AS LOAD_TS_UTC
    FROM source_data
)
SELECT * FROM hashed