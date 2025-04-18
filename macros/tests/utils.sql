{% test no_hash_collision(model, column_name, hashed_fields) %}
    {{ config(severity='warn') }}
    WITH all_tuples AS (
        SELECT DISTINCT {{ column_name }} AS hashed, {{ hashed_fields }}
        FROM {{ model }}
    ),
    validation_errors AS (
        SELECT hashed, count(*)
        FROM all_tuples
        GROUP BY hashed
        HAVING COUNT(*) > 1
    )
    SELECT * FROM validation_errors
{% endtest %}