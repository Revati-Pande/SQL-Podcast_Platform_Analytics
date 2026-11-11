
use podcast_analytics;

select * from episodes;
select * from listeners;
select * from listens;
select * from shows;

-- 5 most recently released episodes
select title, release_date from episodes 
order by release_date desc limit 5;

-- Episodes longer than 50 minutes
select episode_id, title, round((duration_sec/60), 0) as duration_min from episodes
having duration_min > 50
order by duration_min desc;

-- Which shows are the most active producers of content on the platform?
select s.title, count(e.episode_id) as num_of_episodes from episodes as e
inner join shows as s on e.show_id = s.show_id
group by s.title
order by num_of_episodes desc;

-- total listening hours by genre
select s.genre, round(sum(l.seconds_listened/3600), 0) as total_hr from listens as l 
inner join episodes as e on l.episode_id = e.episode_id
inner join shows as s on e.show_id = s.show_id
group by s.genre
order by total_hr desc;

-- For each show, what percentage of listens were completed all the way through?
select s.title, round(avg(l.completed)*100,1) as completion_percent from listens as l 
inner join episodes as e on l.episode_id = e.episode_id
inner join shows as s on e.show_id = s.show_id
group by s.title
order by completion_percent desc;

-- Do listeners binge a show's back catalog, or just listen one episode and move on?
select s.genre, round(avg(episode_count), 3) as avg_episodes_per_listener_per_show
from (select l.listener_id, e.show_id, count(*) as episode_count from listens as l 
inner join episodes as e on l.episode_id = e.episode_id
group by l.listener_id, e.show_id) sub
inner join shows as s on sub.show_id = s.show_id
group by s.genre;

-- How long does it take listeners to discover a new episode after release?
select s.genre, round(avg(datediff(l.listen_date,e.release_date)),0) as avg_days_to_discover from listens as l 
inner join episodes as e on l.episode_id = e.episode_id
inner join shows as s on e.show_id = s.show_id
group by s.genre
order by avg_days_to_discover;

-- Which days of the week see peak listening
select dayname(listen_date) as day_of_week , count(*) as total_listens from listens
group by day_of_week
order by total_listens desc;

-- Top 5 most active listeners by number of listens
select l.name, count(*) as total_listens from listeners as l
inner join listens as lis on l.listener_id = lis.listener_id
group by l.name
order by total_listens desc limit 5;

-- Which countries deliver the most engagement per listener?
select l.country, count(distinct lis.listener_id) as total_listener, round(sum(lis.seconds_listened)/3600,1) as total_hr,
round((sum(lis.seconds_listened)/3600)/ count(distinct lis.listener_id), 3) as hr_per_listeners from listeners as l
inner join listens as lis on l.listener_id=lis.listener_id
group by l.country
order by hr_per_listeners desc;

-- Do premium listeners listen more, or complete more, than free listeners?
select l.subscription_type,
count(distinct l.listener_id) as num_listeners,
round(avg(lis.seconds_listened)/60, 1) as avg_minutes_per_listen,
round(avg(lis.completed) * 100, 1) as completion_pct
from listeners as l
inner join listens as lis on l.listener_id = lis.listener_id
group by l.subscription_type;

-- Monthly listens and unique active listeners
select date_format(listen_date, '%Y-%m') as month, count(*) as total_listens, count(distinct listener_id) as active_listeners
from listens
group by month
order by month;

-- Total listeners on the platform
select count(distinct listener_id) as total_listeners from listeners;

-- Listeners who listened more than 90 days after their signup date
select count(distinct l.listener_id) as listener_after_90_days from listeners as l
inner join listens as lis on l.listener_id = lis.listener_id
where datediff(lis.listen_date, l.signup_date) > 90;

-- Does episode length affect completion rate?
-- Completion rate for shorter episodes (under 30 minutes) = 57.6
select round(avg(l.completed)*100,1) as completion_percent_under30
from listens as l
inner join episodes as e on l.episode_id = e.episode_id
where e.duration_sec < 1800;

-- Completion rate for longer episodes (30 minutes or more)= 58.7
select round(avg(l.completed)*100,1) as completion_percent_over30
from listens as l
inner join episodes as e on l.episode_id = e.episode_id
where e.duration_sec >= 1800;

-- Which shows are gaining or losing listens over time?
-- Listens per show, per month
select s.title, date_format(l.listen_date, '%Y-%m') as month, count(*) as monthly_listens
from listens as l
inner join episodes as e on l.episode_id = e.episode_id
inner join shows as s on e.show_id = s.show_id
group by s.title, month
order by s.title, month;

-- Which shows are doing badly enough that we should probably cancel them?
-- -- Is nobody listening to this show?
-- -- Do people who listen usually quit midway through?
select s.title, count(l.listen_id) as total_listens, round(avg(l.completed)*100,1) as completion_percent from shows as s
inner join episodes as e on s.show_id=e.show_id
inner join listens as l on e.episode_id=l.episode_id
group by s.title
having total_listens < (select count(*)/count(distinct show_id) from listens as l2 inner join episodes as e2 on l2.episode_id=e2.episode_id)
and completion_percent < 55
order by completion_percent;

-- Within each genre, which show is #1, which is #2, which is #3 — ranked by how many minutes people actually spent listening to it?
select genre, title, total_minutes, rank() over (partition by genre order by total_minutes desc) as rank_per_genre
from(select s.genre, s.title, round(sum(l.seconds_listened)/60,0) as total_minutes from shows as s
inner join episodes as e on s.show_id=e.show_id
inner join listens as l on e.episode_id=l.episode_id
group by s.show_id, s.genre, s.title)x;



-- find which genre's shows are mostly listened by listeners with free subscription with completetion percent more than 60%

select s.genre, count(*) as total_listens, round(avg(l.completed)*100,1) as completion_percent from shows as s
inner join episodes as e on s.show_id=e.show_id
inner join listens as l on e.episode_id = l.episode_id
inner join listeners as lis on l.listener_id=lis.listener_id
where lis.subscription_type = 'free' 
group by s.genre
having completion_percent > 50
order by completion_percent;















