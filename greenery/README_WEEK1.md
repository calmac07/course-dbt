
### Week 1 Answers 


**Q1: How many users do we have?**

Answer: 130 

```sql
select count(distinct user_id) from dbt_callum_m.stg_greenery_users ;
```

**Q2: On average, how many orders do we receive per hour?**

Answer: 7.52

```sql
   select avg(count) from 
   
        ( select count(distinct order_id) 
        
                 , date_trunc('hour', created_at) as order_hour_utc
                 
              from dbt_callum_m.stg_greenery_orders
              
                 group by order_hour_utc
                 
                 ) a ;
```
    note: ideal method would be to use datediff function to find time difference between first and last order, 
           but function doesnt seem to work in simple browser ? 

**Q3: On average, how long does an order take from being placed to being delivered?**

Answer: 3 days 21:24:11.803279

```sql
select avg( delivered_at - created_at) 

    from dbt_callum_m.stg_greenery_orders 
    
    where delivered_at is not null 

    and created_at is not null ;
```    

**Q4: How many users have only made one purchase? Two purchases? Three+ purchases?**

Answer: 25 , 28 , 71  

```sql
select order_count , count(distinct user_id) from ( 

    select user_id , (case when order_count >= 3 then 3 else order_count end) as order_count from ( 
    
      select user_id, count(distinct order_id) as order_count from dbt_callum_m.stg_greenery_orders group by 1 ) a
      
    ) b ;
```    

**Q4: On average, how many unique sessions do we have per hour?**

Answer: 16.3

```sql
select round(avg(sessions),4) from ( 

    select date_trunc('hour',created_at) sess_hour
    
           ,count(distinct session_id) as sessions 
           
        from dbt_callum_m.stg_greenery_events 
        
            group by 1 
``` 