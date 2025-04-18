{% test has_no_default_key(model, column_name,
    default_key_value='-1',
    record_source_field_name='RECORD_SOURCE',
    default_key_record_source='System.DefaultKey') -%}
    {{ config(severity = 'error') }}

    WITH default_key_rows AS (
        SELECT DISTINCT {{ column_name }}, {{ record_source_field_name }}
        FROM {{ model }}
        WHERE {{ column_name }} = '{{ default_key_value }}'
        AND {{ record_source_field_name }} = '{{ default_key_record_source }}'
    ),
    validation_errors AS (
        SELECT {{ column_name }}, {{ record_source_field_name }}
        FROM default_key_rows
    )
SELECT * FROM validation_errors

{%- endtest %}