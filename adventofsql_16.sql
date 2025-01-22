with joined as (
  select 
    place_name, 
    timestamp, 
    lag(timestamp, 1) over (
      partition by place_name 
      order by 
        timestamp asc
    ) prev_timestamp --This allows us to work out the time difference at a later step
  from 
    sleigh_locations 
    left join areas on st_intersects(coordinate, polygon) = 't' --Here we can join the areas table on the condition that a sleigh_location intersects an area polygon, giving us the name of that area
) 
select 
  place_name, 
  sum(
    round(
      (
        extract(
          epoch --I have chosen epoch to get the answer in seconds to be more precise before rounding to minutes
          from 
            (timestamp - prev_timestamp)
        )
      )/ 60, 
      0
    )
  ) as time_spent 
from 
  joined 
group by 
  place_name --Find the total time spent in each area
order by 
  time_spent desc
