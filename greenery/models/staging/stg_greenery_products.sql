{{
    config(
        materialized = 'view'
    )
}}

with products_sources as ( select * from {{ source('src_greenery' , 'products') }} )

, renamed_recast as (

    select 
    
        product_id
        ,name
        ,price
        ,inventory

    from products_sources

    )

    select * from renamed_recast 
