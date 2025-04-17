WITH current_data_from_snapshot AS (
    {{
        current_from_snapshot(snsh_ref = ref('snsh_acb_bank_position'), output_load_ts = false)
    }}
)
SELECT *,
       POSITION_VALUE - COST_BASE              AS UNREALIZED_PROFIT,
       ROUND(UNREALIZED_PROFIT / COST_BASE, 5) AS UNREALIZED_PROFIT_PCT
FROM current_data_from_snapshot