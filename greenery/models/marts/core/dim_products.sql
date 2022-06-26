{{
    config( 
    materialized='table'
  )
}}

with orders as ( select 

     product_id 

    ,count(distinct order_id) as distinct_orders

    ,sum(quantity) as total_quanitity_ordered

  from {{ ref ('stg_greenery_order_items') }}

    where product_id is not null 

    group by 1  

    )

, interactions as ( select 

    product_id

    ,count(distinct user_id) total_user_reach
    ,count(distinct event_id) as total_interactions

    ,sum(case when event_type = 'add_to_cart'     then 1 else 0 end ) as add_to_cart_count
    --,sum(case when event_type = 'checkout'        then 1 else 0 end ) as checkout_count
    ,sum(case when event_type = 'page_view'       then 1 else 0 end ) as page_view_count
    --,sum(case when event_type = 'package_shipped' then 1 else 0 end ) as package_shipped_count

from {{ ref ('stg_greenery_events') }}

    where product_id is not null 

    group by product_id 

)

select 

    p.product_id 
    ,p.name
    ,p.price
    ,p.inventory

    ,a.total_user_reach
    ,a.total_interactions

    ,b.distinct_orders
    ,b.total_quanitity_ordered

    ,a.add_to_cart_count
    ,a.page_view_count

    from  {{ ref ('stg_greenery_products') }} p 
    
        left join interactions a using (product_id) 

        left join orders b using (product_id)
