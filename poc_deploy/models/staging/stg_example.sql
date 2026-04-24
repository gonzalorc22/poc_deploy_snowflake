-- models/staging/stg_example.sql
-- Example staging model
-- Replace this with your actual staging model

{{
    config(
        materialized='view'
    )
}}

select
    1 as id,
    'example' as name,
    current_timestamp() as loaded_at
