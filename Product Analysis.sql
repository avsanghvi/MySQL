-- Launched an update on 25thSept 2013 that allows customers to add more than 1 product in cart --
-- What is the click through rate for /cart page, products per order, Average order value, revenue per session? --
-- Anayse data before and after a month of new udate --
Drop table T1;
Create temporary table T1
Select
wp.website_session_id Cart_sessions,
wp.website_pageview_id,
o.items_purchased,
o.price_usd,
case when WP.created_at < '2013-09-25' then 'Pre_Launch' 
when WP.created_at >= '2013-09-25' then 'Post_Launch' else null end as Launch_Time
from website_pageviews wp 
left join orders o on wp.website_session_id = o.website_session_id
WHERE pageview_url = '/cart'
and wp.created_at between '2013-08-25' and '2013-10-25' ;
select *
from T1;
Drop table t2;
Create temporary table t2
select
T1.Cart_Sessions,
MIN(wp.WEBSITE_PAGEVIEW_ID) Nxt_Session,
T1.website_pageview_id,
T1.items_purchased,
T1.price_usd,
T1.Launch_Time
from T1
LEFT JOIN WEBSITE_PAGEVIEWS WP on wp.website_session_id=t1.cart_sessions
and wp.website_pageview_id > t1.website_pageview_id
group by 1;
select
Launch_Time,
count(distinct t2.Cart_sessions) No_of_CartSessions,
count(distinct t2.Nxt_session)/count(distinct t2.Cart_sessions) CTR_of_CartPage,
sum(T2.items_purchased)/count(t2.items_purchased) Products_per_order,
sum(t2.price_usd) Total_Revenue,
sum(t2.price_usd)/count(t2.price_usd) Avg_Order_Value,
sum(t2.price_usd)/count(distinct Cart_sessions) Rev_per_Session
from T2
GROUP BY 1;

-- Launched third product Birthday_Bear on Dec 12, 2013 --
-- Pre-post analysis to compare session-order conv rate, AOV, products per order,
-- and revenue per session month before and after
Drop table T5;
Create temporary table T5
Select
wp.website_session_id Sessions,
o.website_session_id Orders,
wp.website_pageview_id,
o.items_purchased,
o.price_usd,
case when WP.created_at < '2013-12-12' then 'Pre_Birthday_Bear' 
when WP.created_at >= '2013-12-12' then 'Post_Birthday_Bear' else null end as Launch_Time
from website_pageviews wp 
left join orders o on wp.website_session_id = o.website_session_id
WHERE wp.created_at between '2013-11-12' and '2014-01-12';
select
Launch_Time,
count(distinct t5.Sessions) No_of_Sessions,
count(distinct t5.Orders) No_of_Orders,
count(distinct t5.Orders)/count(distinct t5.Sessions) Conv_Rate,
sum(T5.items_purchased)/count(t5.items_purchased) Products_per_order,
sum(t5.price_usd) Total_Revenue,
sum(t5.price_usd)/count(t5.price_usd) Avg_Order_Value,
sum(t5.price_usd)/count(distinct T5.Sessions) Rev_per_Session
from T5
GROUP BY 1
order by 1 DESC;

-- Aalyse product refund rates for each product for each month --

Drop table T6;
Create temporary table t6
select 
year(oi.created_at) Year,
month(oi.created_at) Month,
oi.order_id Orders,
oir.order_id Refunds,
case when oi.product_id = '1' then 'The Original Mr. Fuzzy'
	when oi.product_id = '2' then 'The Forever Love Bear'
    when oi.product_id = '3' then 'The Birthday Sugar Panda'
    when oi.product_id = '4' then 'The Hudson River Mini bear'
    else null end Product_Name
from order_items oi
left join order_item_refunds oir on oi.order_id = oir.order_id;

Select
t6.Year,
T6.Month,
Count(distinct case when product_Name = 'The Original Mr. Fuzzy' then Orders else Null end) 'Mr.Fuzzy_Orders',
Count(distinct case when product_Name = 'The Original Mr. Fuzzy' then Refunds else Null end) 'Mr.Fuzzy_Refunds',
Count(distinct case when product_Name = 'The Forever Love Bear' then Orders else Null end) 'Love_Bear_Orders',
Count(distinct case when product_Name = 'The Forever Love Bear' then Refunds else Null end) 'Love_Bear_Refunds',
Count(distinct case when product_Name = 'The Birthday Sugar Panda' then Orders else Null end) 'Birthday_Panda_Orders',
Count(distinct case when product_Name = 'The Birthday Sugar Panda' then Refunds else Null end) 'Birthday_Panda_Refunds',
Count(distinct case when product_Name = 'The Hudson River Mini bear' then Orders else Null end) 'Mini_Bear_Orders',
Count(distinct case when product_Name = 'The Hudson River Mini bear' then Refunds else Null end) 'Mini_Bear_Refunds'
from T6
Group  by 1,2;




		


