{% snapshot snsh_acb_bank_currency_iso %}
    {{
        config(
            unique_key='CURRENCY_HKEY',
            strategy='check',
            check_cols=['CURRENCY_HDIFF']
        )
    }}
    SELECT * FROM {{ ref('stg_acb_bank_currency_iso') }}
{% endsnapshot %}