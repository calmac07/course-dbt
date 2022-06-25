{{
    config( 
    materialized='table'
  )
}}


-- activity information at user_id level

with base as ( select 

     user_id

    ,min(created_at) as first_activity
    ,max(created_at) as latest_activity 
    ,count(distinct session_id) as total_sessions

    ,count(distinct event_id) as total_events
    ,count(distinct product_id) as total_products_interacted
    ,count(distinct order_id) as total_orders

    ,sum(case when event_type = 'add_to_cart'     then 1 else 0 end ) as total_add_to_carts
    ,sum(case when event_type = 'checkout'        then 1 else 0 end ) as total_checkouts
    ,sum(case when event_type = 'page_view'       then 1 else 0 end ) as total_page_views
    ,sum(case when event_type = 'package_shipped' then 1 else 0 end ) as total_packages_shipped

from {{ ref ('stg_greenery_events') }}

    group by user_id 

)

select 

     a.user_id
    ,first_activity
    ,latest_activity 
    ,(date_part('day', current_date - first_activity::timestamp )) as days_as_member
    ,total_sessions
    ,b.total_active_minutes

    ,total_events
    ,total_products_interacted
    ,total_orders

    ,total_add_to_carts
    ,total_checkouts
    ,total_page_views
    ,total_packages_shipped

from base a

  left join ( select 

                    user_id 

                    ,sum(session_length_minutes) as total_active_minutes 
                    
                from {{ ref ('fct_sessions') }}

                  group by 1
                  
             ) b using (user_id)





