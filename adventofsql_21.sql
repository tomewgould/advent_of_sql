--select * from sales
with sum_amount as (
  select 
    date_part('year', sale_date) as year, -- Parse year of each sale date
    date_part('quarter', sale_date) as quarter, -- Parse quarter of each sale date
    sum(amount) as total_sales 
  from 
    sales 
  group by 
    year, 
    quarter
) 
select 
  year, 
  quarter, 
  total_sales, 
  lag(total_sales, 1) over ( -- Retrieve sales from previous quarter to same row as current quarter
    order by 
      year asc, 
      quarter asc
  ) prev_q_sales, 
  total_sales / lag(total_sales) over (
    order by 
      year, 
      quarter
  ) as growth_rate 
from 
  sum_amount 
order by 
  growth_rate desc nulls last -- nulls last allows us to return the top non null value for growth_rate
