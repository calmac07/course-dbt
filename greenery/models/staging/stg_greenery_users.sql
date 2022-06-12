{{
    config(
        materialized = 'view'
    )
}}

with users_sources as ( select * from {{ source('src_greenery' , 'users') }} )

, renamed_recast as (

    select 

        user_id
        , first_name  -- as user_guid
        , last_name
        , email
        , phone_number
        , created_at -- as created_at_utc
        , updated_at -- as updated_at_utc
        , address_id -- as address_guid

    from users_sources

    )

    select * from renamed_recast 
