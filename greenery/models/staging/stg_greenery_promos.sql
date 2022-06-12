{{
    config(
        materialized = 'view'
    )
}}

with promos_sources as ( select * from {{ source('src_greenery' , 'promos') }} )

, renamed_recast as (

    select 

        promo_id
        ,discount
        ,status

    from promos_sources

    )

    select * from renamed_recast 
