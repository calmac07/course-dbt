{{
  config(
    materialized='table'
  )
}}


select

    case when a.promo_id is null then 'no_promo' else a.promo_id end as promo_id

   ,b.status as current_status        
   ,b.discount 

   ,count(distinct order_id) total_orders
   ,count(distinct user_id) user_reach

   ,min(created_at) first_order
   ,max(created_at) latest_order

   ,sum(order_cost) total_order_cost
   ,sum(shipping_cost) associated_shipping_cost
   ,sum(order_total) order_total

   ,sum ( case when a.status = 'preparing' then 1 else 0 end ) as total_status_preperation
   ,sum ( case when a.status = 'delivered' then 1 else 0 end ) as total_status_delivered
   ,sum ( case when a.status = 'shipped'   then 1 else 0 end ) as total_status_shipped


from {{ ref('stg_greenery_orders') }} a

  left join {{ ref('stg_greenery_promos') }} b using(promo_id)

  group by 1 , 2 , 3
