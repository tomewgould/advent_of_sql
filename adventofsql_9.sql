-- Will need to combine aggregate functions and CTEs
with cte_a as (
  select 
    r.reindeer_name, 
    ts.exercise_name, 
    avg(ts.speed_record) as avg_speed -- aggregate function
  from 
    training_sessions ts 
    join reindeers r on ts.reindeer_id = r.reindeer_id 
  where 
    reindeer_name != 'Rudolph' -- exclude Rudolph
  group by 
    reindeer_name, 
    exercise_name -- grouping by reindeer name and exercise to find avg speed
    ), 
cte_b as (
  -- second cte
  select 
    reindeer_name, 
    exercise_name, 
    round(avg_speed, 2) as speed 
  from 
    cte_a 
  order by 
    avg_speed desc -- order by desc to find top 3 easier
    ) 
select 
  * 
from 
  cte_b
