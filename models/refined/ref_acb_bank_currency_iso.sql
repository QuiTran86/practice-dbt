WITH current_data_from_snapshot AS (
    SELECT * EXCLUDE (DBT_SCD_ID, DBT_UPDATED_AT, DBT_VALID_FROM, DBT_VALID_TO)
    FROM {{ ref('snsh_acb_bank_currency_iso') }}
    WHERE DBT_VALID_TO IS NULL
)
SELECT * FROM current_data_from_snapshot