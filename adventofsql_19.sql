with unnested as (
  select 
    employee_id, 
    name, 
    salary, 
    year_end_performance_scores, 
    perf_scores, 
    row_number() over (
      partition by employee_id 
      order by 
        employee_id
    ) as rn 
  from 
    employees, 
    unnest(year_end_performance_scores) perf_scores -- Would have been cleaner to use array_upper here
), 
avg_score as (
  select 
    avg(perf_scores) as ye_avg 
  from 
    unnested 
  where 
    rn = 5 -- Taking the last value in the year_end_performance_scores array as the appropriate score
), 
tc_calc as (
  select 
    name, 
    salary, 
    perf_scores, 
    ye_avg, 
    case when perf_scores > ye_avg then salary * 1.15 else salary end as total_comp 
  from 
    unnested cross -- cross join allows us to append single value to table easily
    join avg_score 
  where 
    rn = 5
) 
select 
  round(
    sum(total_comp), 
    2
  ) 
from 
  tc_calc
