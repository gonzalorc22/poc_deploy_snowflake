-- models/marts/mart_example.sql
-- Example marts model
-- Replace this with your actual marts model

{{
    config(
        materialized='table'
    )
}}

select
    id,
    name,
    loaded_at
from {{ ref('stg_example') }}
