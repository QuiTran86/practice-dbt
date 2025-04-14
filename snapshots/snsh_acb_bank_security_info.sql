{% snapshot snsh_acb_bank_security_info %}
    {{
        config(
            unique_key='SECURITY_HKEY',
            strategy='check',
            check_cols=['SECURITY_HDIFF']
        )
    }}
    SELECT * FROM {{ ref('stg_acb_bank_security_info') }}
{% endsnapshot %}