{{
  config(
    materialized='table'
  )
}}


select

   a.user_id
  ,a.first_name
  ,a.last_name

  --,a.address_id
  ,b.country
  ,b.state

  ,c.first_activity
  ,c.latest_activity 
  ,c.days_as_member
  ,c.total_sessions
  ,c.total_active_minutes

  ,c.total_events
  ,c.total_products_interacted
  ,c.total_orders

  ,c.total_add_to_carts
  ,c.total_checkouts
  ,c.total_page_views
  ,c.total_packages_shipped

from {{ ref('stg_greenery_users') }} a

  left join {{ ref('stg_greenery_addresses') }} b using(address_id)

  left join {{ ref('int_user_events_agg') }} c using (user_id) 
