-- How much traffic is coming from each campaign -- 
Select
utm_source,
utm_campaign,
utm_content,
http_referer,
count(distinct website_session_id) as Sessions
from website_sessions
group by 1,2,3
order by sessions desc;

-- How many and what percentage of sessions converted into order ? --
select
count(distinct ws.website_session_id) as sessions,
count(distinct o.order_id) as orders,
count(distinct o.order_id)/count(distinct ws.website_session_id)*100  Conversion_rate
from website_sessions ws 
left join orders o on ws.website_session_id = o.website_session_id;

-- Impact of reducing a budget for particular campaign on traffic--
-- Bid down gsearch nonbrand on 15-4-2012,Find out weekly trend of traffic before ad after bidding down --
select
min(date(created_at)),
count(distinct website_session_id)
from website_sessions
where created_at between '2012-01-15' and '2012-07-15' 
and utm_source = 'gsearch'
and utm_campaign = 'nonbrand'
group by week(created_at);

-- What is the conversion rate based on device_type for each different utm_source--

select
utm_source,
count(distinct case when device_type= 'mobile' then o.website_session_id else null end)/
count(distinct case when device_type= 'mobile' then ws.website_session_id else null end)*100 as CVR_MOBILE,
count(distinct   case  when device_type = 'desktop' then  o.website_session_id else null end)/
count(distinct   case  when device_type = 'desktop' then  ws.website_session_id else null end)*100 AS CVR_DESKTOP
from website_sessions ws 
left join orders o on ws.website_session_id = o.website_session_id
  GROUP BY utm_source;

-- 






