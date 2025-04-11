{% snapshot snsh_acb_bank_position %}
    {{
        config(
            unique_key='POSITION_HKEY',
            strategy='check',
            check_cols=['POSITION_HDIFF'],
            invalidate_hard_deletes=True
        )
    }}
    SELECT * FROM {{ ref('stg_acb_bank_position') }}
{% endsnapshot %}