{{
    config(
    materialized='table'
  )
}} 


with start_and_end as ( select 

    session_id
    ,min(created_at) as session_start
    ,max(created_at) as session_end
    
from {{ ref ('stg_greenery_events') }}

    group by session_id 

)

select session_id
       ,session_start
       ,session_end
       ,( date_part('day', session_end::timestamp - session_start::timestamp)  *24.0  + 
          date_part('hour', session_end::timestamp - session_start::timestamp)) *60.0  +
          date_part('minute', session_end::timestamp - session_start::timestamp)*1.0
        as session_length_minutes

    from start_and_end       



