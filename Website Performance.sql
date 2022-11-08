-- Top website pages--
SELECT 
pageview_url,
count(distinct website_pageview_id)
FROM website_pageviews
group by 1
order by 2 desc;

-- Top lending pages --
Select 
pageview_url,
count(distinct lending_page)
from (
select
min(website_pageview_id) as lending_page,
website_session_id,
pageview_url
from website_pageviews
group by website_session_id) as Lending_pageT
group by pageview_url;

-- Calculate Bounce Rate for /home page --
select
count(distinct website_session_id) Total_sessions,
count(distinct case when No_of_sessions = 1 then website_session_id else null end) Bounced_sessions,
count(distinct case when No_of_sessions = 1 then website_session_id else null end)/ count(distinct website_session_id) Bounce_rate
from(
select
website_session_id,
count(website_session_id) as No_of_sessions,
min(website_pageview_id),
pageview_url
from website_pageviews
group by website_session_id
having pageview_url = '/home'
) Temporary_1;

-- Analyzing lending page rates (50/50 Test) --
-- Company introduced new /lander-1 page--
-- Compare the bounce rate for /home and /lander-1 page after the launch of /lander-1 --
select
pageview_url,
count(distinct case when pageview_url = '/home' then website_session_id 
 when pageview_url = '/lander-1' then website_session_id end ) Total_sessions,
count(distinct case when No_of_sessions = 1 and pageview_url = '/home' then website_session_id
 when No_of_sessions = 1 and pageview_url = '/lander-1' then website_session_id else null end) Bounced_sessions,
 count(distinct case when No_of_sessions = 1 and pageview_url = '/home' then website_session_id
 when No_of_sessions = 1 and pageview_url = '/lander-1' then website_session_id else null end)/
count(distinct case when pageview_url = '/home' then website_session_id 
 when pageview_url = '/lander-1' then website_session_id end ) as Bounce_Rate
from(
select
website_session_id,
count(website_session_id) as No_of_sessions,
min(website_pageview_id),
pageview_url
from website_pageviews
group by website_session_id
having pageview_url = '/home' or pageview_url = '/lander-1') as Temporary_2
group by pageview_url