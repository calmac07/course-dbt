{{
    config(
    materialized='table'
  )
}}

select 

    session_id
    ,user_id

    ,count(distinct event_id) as event_count
    ,count(distinct product_id) as interacted_product_count
    ,count(distinct order_id) as order_count

    ,sum(case when event_type = 'add_to_cart'     then 1 else 0 end ) as add_to_cart_count
    ,sum(case when event_type = 'checkout'        then 1 else 0 end ) as checkout_count
    ,sum(case when event_type = 'page_view'       then 1 else 0 end ) as page_view_count
    ,sum(case when event_type = 'package_shipped' then 1 else 0 end ) as package_shipped_count

from {{ ref ('stg_greenery_events') }}

    group by session_id , user_id 