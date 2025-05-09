{{ config(materialized='ephemeral') }}

WITH source_data AS (
    SELECT *,
    'SEED.ACB_BANK_COUNTRY_ISO' AS RECORD_RESOURCE
    FROM {{ source('seeds', 'ACB_BANK_COUNTRY_ISO')}}
),
hashed AS (
    SELECT {{ dbt_utils.generate_surrogate_key(['COUNTRY_CODE_NUMERIC']) }} AS COUNTRY_CODE_HKEY,
    {{ dbt_utils.generate_surrogate_key(['COUNTRY_CODE_NUMERIC', 'COUNTRY_NAME', 'REGION',
    'REGION_CODE', 'SUB_REGION', 'SUB_REGION_CODE']) }} AS COUNTRY_CODE_HDIFF,
    * EXCLUDE LOAD_TS,
    LOAD_TS AS LOAD_TS_UTC
    FROM source_data
)
SELECT * FROM hashed