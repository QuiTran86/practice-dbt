{% snapshot snsh_acb_bank_country_iso %}
    {{
        config(
            unique_key='COUNTRY_CODE_HKEY',
            strategy='check',
            check_cols=['COUNTRY_CODE_HDIFF']
        )
    }}
    SELECT * FROM {{ ref('stg_acb_bank_country_iso') }}
{% endsnapshot %}