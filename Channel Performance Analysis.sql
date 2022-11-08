-- Introduce new channel bsearch on Aug 22-2012--
-- Compare traffic between gsearch nonbrand and bsearch weekly for year 2012 --

SELECT 
min(date(created_at)),
count(distinct case when utm_source = 'gsearch' and utm_campaign ='nonbrand' then website_session_id else null end) gsearch,
count(distinct case when utm_source = 'bsearch' and utm_campaign ='nonbrand' then website_session_id else null end) bsearch
FROM website_sessions
where created_at > '2012-08-22' and created_at < '2012-12-31' 
group by week(created_at);

-- What percentage of sessions for gsearch and bsearch are coming from different device? --
select
utm_source,
round(count(distinct case when device_type = 'mobile' then website_session_id else null end)/count(distinct website_session_id)*100,2) as Mobile_sessions,
round(count(distinct case when device_type = 'desktop' then website_session_id else null end)/count(distinct website_session_id)*100,2) as Desktop_sessions
from website_sessions
where utm_source = 'gsearch' or utm_source ='bsearch'
	group by utm_source;

-- Bid optimization--
-- What is session to order conversion rate for gsearch and bsearch for different devices?--
select
utm_source,
count(distinct case when device_type = 'mobile' then ws.website_session_id else null end) as Mobile_sessions,
count(distinct case when device_type = 'mobile' then o.website_session_id else null end) as Mobile_orders,
round(count(distinct case when device_type = 'mobile' then o.website_session_id else null end)/
count(distinct case when device_type = 'mobile' then ws.website_session_id else null end)*100,2) as Conv_Rate_M,
count(distinct case when device_type = 'desktop' then ws.website_session_id else null end) as Desktop_sessions,
count(distinct case when device_type = 'desktop' then o.website_session_id else null end) as Desktop_orders,
round(count(distinct case when device_type = 'desktop' then o.website_session_id else null end)/
count(distinct case when device_type = 'desktop' then ws.website_session_id else null end)*100,2) as Conv_Rate_D
from website_sessions ws 
left join orders o on ws.website_session_id=o.website_session_id
where ws.utm_source = 'gsearch' or ws.utm_source ='bsearch'
group by ws.utm_source




