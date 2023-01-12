-- Analysing Seasonality --
-- Which month of the year has high session-order ratio?--
select
year(ws.created_at) Year,
month(ws.created_at) Month,
count(distinct ws.website_session_id) sessions,
count(distinct o.website_session_id) orders
from website_sessions ws
left join orders o on ws.website_session_id=o.website_session_id
group by 2,1
order by 1,2 asc;
-- Analysing Business Patterns for each hour of each day--
-- finding a hour of the day having highest traffic--
select
hour(created_at),
count(distinct case when weekday(created_at) = 0 then website_session_id else null end) Monday,
count(distinct case when weekday(created_at) = 1 then website_session_id else null end) Tuesday,
count(distinct case when weekday(created_at) = 2 then website_session_id else null end) Wedday,
count(distinct case when weekday(created_at) = 3 then website_session_id else null end) Thursday,
count(distinct case when weekday(created_at) = 4 then website_session_id else null end) Friday,
count(distinct case when weekday(created_at) = 5 then website_session_id else null end) Saturday,
count(distinct case when weekday(created_at) = 6 then website_session_id else null end) Sunday
from website_sessions
group by 1
order by 1;


