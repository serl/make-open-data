{{ 
    config(
        materialized='view',
        schema='intermediaires'
    ) 
}}

WITH logement AS (
    select * 
    {% if target.name == 'production' %}
        from {{ source('sources', 'logement_2020') }}
    {% else %}
        from {{ source('sources', 'logement_2020_dev') }}
    {% endif %}
),
logement_renomee AS (
    ( {{ renommer_colonnes_values_logement(logement, 'demographie') }} )
)

SELECT 
    *
FROM 
    logement_renomee