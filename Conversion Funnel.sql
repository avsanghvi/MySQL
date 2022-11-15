Drop table T6;
Create Temporary Table T6
select website_session_id,
case when pageview_url = '/the-original-mr-fuzzy' then 'Mr_Fuzzy'
WHEN pageview_url = '/the-birthday-sugar-panda' then 'Sugar_Panda' 
WHEN pageview_url = '/the-hudson-river-mini-bear' then 'Hudson_bear' 
WHEN pageview_url = '/the-forever-love-bear' then 'Love_bear' else null end as Prodct_Name
from website_pageviews;
Drop Table T7;
Create Temporary Table T7
Select website_session_id,
Prodct_Name
from T6
where Prodct_Name is not null;
Select
Prodct_Name,
count(distinct case 
when wp.pageview_url = '/the-original-mr-fuzzy' then wp.website_session_id 
when wp.pageview_url = '/the-birthday-sugar-panda' then wp.website_session_id 
when wp.pageview_url = '/the-hudson-river-mini-bear' then wp.website_session_id 
when wp.pageview_url = '/the-forever-love-bear' then wp.website_session_id 
else null end) as Total_Sessions,
count(distinct case when wp.pageview_url = '/cart'  then wp.website_session_id else null end) as Cart,
count(distinct case when wp.pageview_url = '/shipping'then wp.website_session_id else null end) as Shipping,
count(distinct case 
when wp.pageview_url = '/billing-2' then wp.website_session_id 
when wp.pageview_url = '/billing' then wp.website_session_id 
else null end) as Billing,
count(distinct case when wp.pageview_url = '/thank-you-for-your-order'  then wp.website_session_id else null end) as ThankYou
from T7
JOIN website_pageviews wp on T7.website_session_id=wp.website_session_id
group by Prodct_Name;

Prodct_Name	Total_Sessions	Cart	Shipping	Billing	ThankYou
Hudson_bear	2610	1700	1148	918	581
Love_bear	26033	14485	9732	7738	4803
Mr_Fuzzy	162525	69957	47601	38586	23861
Sugar_Panda	19046	8811	6003	4816	3068
