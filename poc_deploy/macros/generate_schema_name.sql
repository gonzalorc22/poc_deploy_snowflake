{# macros/generate_schema_name.sql #}
{# This macro controls how dbt generates schema names. #}
{# By default, dbt appends a custom schema to the target schema. #}
{# This override uses ONLY the custom schema if provided. #}

{% macro generate_schema_name(custom_schema_name, node) -%}
    {%- set default_schema = target.schema -%}
    {%- if custom_schema_name is none -%}
        {{ default_schema }}
    {%- else -%}
        {{ custom_schema_name | trim }}
    {%- endif -%}
{%- endmacro %}
