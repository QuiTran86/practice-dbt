{% macro ls_2_str(columns) -%}
    {{ columns | join(', ')}}
{%- endmacro%}