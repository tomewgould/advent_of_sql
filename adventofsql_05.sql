with cte as (
  select 
    production_date, 
    toys_produced, 
    lag(toys_produced, 1) over (
      order by 
        production_date
    ) previous_day_production 
  from 
    toy_production 
  order by 
    production_date desc
) 
select 
  *, 
  (
    toys_produced - previous_day_production
  ) as production_change, 
  round(
    (
      toys_produced - previous_day_production
    )* 100 / previous_day_production, 
    2
  ) as production_change_percentage 
from 
  cte 
order by 
  production_change_percentage desc
