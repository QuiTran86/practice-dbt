WITH current_data_from_snapshot AS (
    {{
        current_from_snapshot(snsh_ref = ref('snsh_acb_bank_country_iso'))
    }}
)
SELECT * FROM current_data_from_snapshot