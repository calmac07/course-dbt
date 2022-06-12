{{
    config(
        materialized = 'view'
    )
}}

with order_items_sources as ( select * from {{ source('src_greenery' , 'order_items') }} )

, renamed_recast as (

    select 

        order_id
        ,product_id
        ,quantity

    from order_items_sources

    )

    select * from renamed_recast 