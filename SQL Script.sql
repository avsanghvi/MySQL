SELECT 
is_repeat_session,
count(distinct ws.website_session_id) sessions,
count(distinct o.website_session_id) sessions,
count(distinct o.website_session_id)/count(distinct ws.website_session_id)  as conv	,
sum(price_usd)/count(distinct ws.website_session_id) as rev
FROM mavenfuzzyfactory.website_sessions ws
left join orders o on ws.website_session_id=o.website_session_id
where ws.created_at >= '2014-01-01' and ws.created_at < '2014-11-08'
group by ws.is_repeat_session
