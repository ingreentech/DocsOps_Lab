-- Q1: What are the 10 most recent releases of simonw/datasette?
select tag_name, name, published_at
from releases
where project = 'simonw/datasette'
order by published_at desc
limit 10;
-- Rows returned: 10

-- Q2: Which prereleases does encode/httpx have, oldest first?
select tag_name, published_at 
from releases 
where project = 'encode/httpx'
and prerelease = 1
order by published_at asc;
-- Rows returned: 4

-- Q3a: Which releases have “alpha” in their name or in their tag?
select project, name, tag_name 
from releases 
where tag_name
like '%alpha%' or name like '%alpha%';
-- Rows returned: 0

-- Q3b: Which releases have “alpha” in their name or in their tag?
select project, name, tag_name 
from releases 
where tag_name
like '%beta%' or name like '%beta%';
-- Rows returned: 1


-- Q4: Which releases of simonw/datasette and simonw/sqlite-utils were published in 2025, newest first?
select project, tag_name, published_at
from releases
where project in ('simonw/sqlite-utils', 'simonw/datasette')
and published_at >= '2025-01-01' and published_at < '2026-01-01'
order by published_at desc;
-- Rows returned: 11 

-- Q5: Which projects have releases with no name?
select distinct project 
from releases
where name = '';
-- Rows returned: 1
