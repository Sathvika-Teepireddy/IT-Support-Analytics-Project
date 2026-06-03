 -- QUERY 1: How many tickets per category?
 select * from tickets;
 select category,count(*) as total_tickets from tickets group by category;
 -- desc order?(highest to lowest)
 select category,count(*) as total_tickets from tickets group by category order by total_tickets desc;
 
 -- QUERY 2 : Which category is performing poorly which has breach?
 select category, 
 sum(case when is_breach = 'true' then 1 else 0 end) as breach_tickets  from tickets group by category order by breach_tickets desc;
 
 -- QUERY 3 : Breach rate percentage?
select category,count(*) as total_tickets,
sum(case when is_breach = 'true' then 1 else 0 end) as breach_tickets,
round(100.0*sum(case when is_breach = 'true' then 1 else 0 end)/count(*),1) as breach_rate_per from tickets 
group by category order by breach_rate_per desc;

-- alias:-
 -- alias will work only for order by else no where we can use alias in our query 
 -- FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY
 -- So alias is created in SELECT stage → too late for WHERE/GROUP BY.
 
 -- steps performed:-
 -- so here we performed total_tickets count for each category - that gives us how many tickets for category 
 -- as of our business requirement our main aim is to get to know about the breaches occurance (which is a performance issue where SLA is not met)
 -- SUM(is_breach) = volume of failures , breach_rate_pct = severity of failures

-- analysis:-
-- According to the query result we found that malware alert,phishing email has severity of failures it is acrount 48% and 41% near to 50%

 -- QUERY 4 :- After-hours breach analysis
 -- Business Question: "Are night-time tickets more dangerous?"
 
 -- this is sum of after hours tickets per category
select category, 
sum(case when after_hours = 'true' then 1 else 0 end) as after_hours_tickets from tickets
group by category ;

-- lets check after_hours tickets how many are breached tickets
select after_hours,
count(*) as total,
sum(case when is_breach = 'true' then 1 else 0 end) as breaches from tickets 
group by after_hours;

-- here the analysis what we got is after_hours breaches are around 90.
-- after_hours breaches per category

SELECT category,
SUM(CASE WHEN after_hours = 'true' AND is_breach = 'true' THEN 1 ELSE 0 END) AS after_hours_breaches
FROM tickets
GROUP BY category;

-- breach rate
select after_hours,
count(*) as total,
sum(case when is_breach = 'true' then 1 else 0 end) as breaches,
round(100.0*sum(case when is_breach = 'true' then 1 else 0 end)/count(*),1) as breach_rate from tickets 
group by after_hours;
 -- based on analysis After-hours tickets are more likely to breach SLA because their breach rate is 30%, compared to 25% for tickets raised during business hours.

-- QUERY 5:-
-- In IT support, "dangerous" usually means:
-- More likely to breach SLA
-- Take longer to resolve - avg_resolution_hrs
-- Need special attention
-- resolution_hrs for after_hr breaches and non_after_hr breaches.

SELECT after_hours, COUNT(*) AS total,
SUM(case when is_breach = 'true' then 1 else 0 end) AS breaches,
ROUND(AVG(resolution_time), 1) AS avg_resolution_hrs
FROM tickets
GROUP BY after_hours;

-- QUERY 6:-priority breaches
select priority, count(*) as total,sum(case when is_breach = 'true' then 1 else 0 end) AS breaches
from tickets 
group by priority
order by breaches desc;
-- this gives us Which priority levels contribute the most SLA breaches, according to this we can see critical and high have >80 breaches.

-- QUERY 7:- Repeated issue
select repeated_issue,count(*) as total, sum(case when is_breach = 'true' then 1 else 0 end) as breaches
from tickets
group by repeated_issue;
-- according to the analysis the repeated issues have less breaches comparitively than non repeated

-- QUERY 8:- Monthly breaches
-- Business Question: "Is it getting worse over time?"
select date_format(date, '%y-%m') as month , count(*) as total_tickets,
sum(case when is_breach = 'true' then 1 else 0 end) as breaches from tickets 
group by date_format(date, '%y-%m')
order by month;
-- which 3 months has highest breaches?

select date_format(date, '%y-%m') as month , count(*) as total_tickets,
sum(case when is_breach = 'true' then 1 else 0 end) as breaches from tickets 
group by date_format(date, '%y-%m')
order by breaches desc
limit 3;
-- monthname with year and the highest breaches in which months
select date_format(date, '%M - %Y') as month_name , count(*) as total_tickets,
sum(case when is_breach = 'true' then 1 else 0 end) as breaches from tickets 
group by date_format(date, '%M - %Y')
order by breaches desc
limit 3;

-- QUERY-8 High-risk tickets (for dashboard)
-- Business Question: "Which tickets need URGENT attention?"
select * from tickets 
where is_breach = 'true'
and priority in ('high','critical')
order by date desc
limit 20;

-- here it shows the latest 20 priority breached tickets.
