
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

Some things i would explore for the following

- User interactions and correlation to buy intent related metrics 
- Does the user return (regardless of purchase), testing for 'stickiness' ?
- Identifying patterns in end user journeys and how they correlate to purchase (e.g. users who come from certain traffic sources etc)
- How do end users react to promos , and would interactions with certain promo items indicate higher purchase intent? 

**Explain the marts models you added. Why did you organize the models in the way you did?**

- Wanted the data to be able to give perspective on how the product is doing at the session, user and product level. 
- Also did an aggregated table at the promo_id level 
- Used INT tables to aggregate data and apply calculations , then join to other relevant summary data in final tables 

**What assumptions are you making about each model? (i.e. why are you adding each test?)**
- Alot of the time , assuming there should not be duplicate entires for the top level metric in question (e.g session_id for table relating to sessions, produc_id for products etc)
- Note: could use utils function and hash a primary key instead of relying on one specific column each time 
- for user data, models assume that email info has not changed (risk of duplicating entires if the same user has multiple emails, if joining on name info ?)


**Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?**
- Yes, NULLs to some relevant columns in things such as orders etc. Removed NULL entries when neccessary (e.g product_id null for interactions )