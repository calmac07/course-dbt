{{
    config(
        materialized = 'view'
    )
}}

with addresses_sources as ( select * from {{ source('src_greenery' , 'addresses') }} )

, renamed_recast as (

    select 

        address_id
        ,address
        ,zipcode
        ,state 
        ,country

    from addresses_sources

    )

    select * from renamed_recast 