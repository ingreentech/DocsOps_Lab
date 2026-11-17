-- Q1: How many releases does each project have, most first?
select project, count(*) as "# of releases"
from releases
group by project
order by "# of releases" desc;
-- Rows returned: 4

-- Q2: How many releases were published in each year across all projects, oldest year first?
select strftime('%Y', published_at) as year, count(*) as "# of releases"
from releases
group by year
order by year asc;
-- Rows returned: 10

-- Q3: What are the first and last release dates for each project?
select project, min(published_at) as "first release", max(published_at) as "latest release"
from releases
where project in ('simonw/sqlite-utils', 'encode/httpx', 'pallets/click', 'simonw/datasette')
group by project;
-- project	first release	latest release
-- encode/httpx	2019-08-29T14:45:37Z	2024-12-06T15:36:24Z
-- pallets/click	2020-03-09T19:00:29Z	2026-11-06T17:38:44Z
-- simonw/datasette	2017-11-16T16:01:35Z	2026-11-08T23:55:18Z
-- simonw/sqlite-utils	2019-01-25T07:27:57Z	2026-08-13T23:53:47Z
-- Rows returned: 4

-- Q4: Which projects have more than 50 releases?
select project, count(*) as "# of releases"
from releases
where project in ('simonw/sqlite-utils', 'encode/httpx', 'pallets/click', 'simonw/datasette')
group by project
having count(*) > 50;
-- project	# of releases
-- encode/httpx	51
-- simonw/datasette	176
-- simonw/sqlite-utils	129
-- Rows returned: 3

-- Q5: In which months did simonw/datasette publish 3 or more releases, most active months first?
select strftime('%Y-%m', published_at) as month, count(*) as "# of releases"
from releases
where project = 'simonw/datasette'
group by month
having count(*) >= 3
order by "# of releases" desc, month desc;
-- Rows returned: 25
