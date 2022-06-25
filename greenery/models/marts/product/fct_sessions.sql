
{{
    config(
    materialized='table'
  )
}}


select 

    a.user_id
    --,count(a.session_id)over(partition by a.user_id order by b.session_start asc ) as user_session_number

    ,a.session_id
    ,b.session_start
    ,b.session_end
    ,b.session_length_minutes

    ,a.event_count
    ,a.interacted_product_count
    ,a.order_count
    ,a.add_to_cart_count
    ,a.checkout_count
    ,a.page_view_count
    ,a.package_shipped_count

    from {{ ref ('int_session_events_agg') }} a

    left join {{ ref ('int_session_lenghts') }} b using (session_id) 