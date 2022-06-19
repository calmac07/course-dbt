
**Q1: What is our repeat rate?**

Answer: 79.84%

```sql

with order_base as ( 

  select distinct user_id , count(*) orders 

    from ( select distinct user_id , order_id from dbt_callum_m.stg_greenery_orders ) a
  
    group by user_id 

  )
  
  select count(*) total 
  
        , (select count(*) from order_base where orders > 1 ) as repeat_customer
        
        , round(100.0*(select count(*) from order_base where orders > 1 ) / count(*),2) as percentage
        
        from order_base ;

```


**Q2: What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?**

- 
-
-
