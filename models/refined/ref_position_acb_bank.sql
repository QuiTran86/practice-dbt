WITH current_data_from_snapshot AS (SELECT *
                                    FROM {{ ref('snsh_acb_bank_position') }}
                                    WHERE DBT_VALID_TO IS NULL -- It means the data is still latest
)
SELECT *,
       POSITION_VALUE - COST_BASE              AS UNREALIZED_PROFIT,
       ROUND(UNREALIZED_PROFIT / COST_BASE, 5) AS UNREALIZED_PROFIT_PCT
FROM current_data_from_snapshot