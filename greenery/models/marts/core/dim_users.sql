{{
  config(
    materialized='table'
  )
}}


-- user_info, join to user_events_agg
-- plus geog info


SELECT

  u.user_id,
  u.first_name,
  u.last_name,



FROM {{ ref('stg_greenery_users') }} u

  left join 


