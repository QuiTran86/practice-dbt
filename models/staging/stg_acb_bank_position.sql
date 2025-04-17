{{ config(materialized='ephemeral') }}


WITH src_data AS (
    SELECT ACCOUNTID                                                    AS ACCOUNT_CODE,
           SYMBOL                                                       AS SECURITY_CODE,
           DESCRIPTION                                                  AS SECURITY_NAME,
           EXCHANGE                                                     AS EXCHANGE_CODE,
           {{ to_21st_century_date('REPORT_DATE')}}                     AS REPORT_DATE,
           QUANTITY                                                     AS QUANTITY,
           COST_BASE                                                    AS COST_BASE,
           POSITION_VALUE                                               AS POSITION_VALUE,
           CURRENCY                                                     AS CURRENCY_CODE,
           'SOURCE_DATA.ACB_BANK_POSITION'                              AS RECORD_SOURCE
           FROM {{ source('abc_bank', 'ACB_BANK_POSITION') }}
),
hashed as (
SELECT
    {{ dbt_utils.generate_surrogate_key(['ACCOUNT_CODE', 'SECURITY_CODE'])}} as POSITION_HKEY,
    {{ dbt_utils.generate_surrogate_key(['ACCOUNT_CODE', 'SECURITY_CODE', 'SECURITY_NAME', 'EXCHANGE_CODE', 'REPORT_DATE',
    'QUANTITY', 'COST_BASE', 'POSITION_VALUE', 'CURRENCY_CODE' ])}} as POSITION_HDIFF,
    * ,
    '{{ run_started_at }}' as LOAD_TS_UTC
FROM src_data
)


SELECT *
FROM hashed