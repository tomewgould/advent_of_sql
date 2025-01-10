--Will use window functions to find rolling average.
select 
  field_name, 
  harvest_year, 
  season, 
  round(
    avg(trees_harvested) over (
      rows between 2 preceding 
      and current row
    ), 
    2
  ) as three_season_moving_average -- Calculates avg over current and 2 preceding rows. Records already in correct order.
from 
  TreeHarvests 
order by 
  three_season_moving_average desc 
limit 
  1 -- Return top result
