{{ config(materialized='ephemeral') }}


WITH src_data AS (SELECT ACCOUNTID                       AS ACCOUNT_CODE,
                         SYMBOL                          AS SECURITY_CODE,
                         DESCRIPTION                     AS SECURITY_NAME,
                         EXCHANGE                        AS EXCHANGE_CODE,
                         REPORT_DATE                     AS REPORT_DATE,
                         QUANTITY                        AS QUANTITY,
                         COST_BASE                       AS COST_BASE,
                         POSITION_VALUE                  AS POSITION_VALUE,
                         CURRENCY                        AS CURRENCY_CODE,
                         'SOURCE_DATA.ACB_BANK_POSITION' AS RECORD_SOURCE
                  FROM {{ source('abc_bank', 'ACB_BANK_POSITION') }}),

     hashed AS (SELECT CONCAT_WS('|', ACCOUNT_CODE, SECURITY_CODE)                                               AS POSITION_HKEY,
                       CONCAT_WS('|', ACCOUNT_CODE, SECURITY_CODE, SECURITY_NAME,
                                 EXCHANGE_CODE, REPORT_DATE, QUANTITY, COST_BASE, POSITION_VALUE,
                                 CURRENCY_CODE)                                                                  AS POSITION_HDIFF,
                       *,
                       '{{ run_started_at }}'                                                                    AS LOAD_TS_UTC
                FROM src_data
     )


SELECT * FROM hashed