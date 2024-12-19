--Join tables together on child_id and use a subquery in the WHERE clause to filter for gifts with > avg price

select 
  c.name as child_name, 
  g.name as gift_name, 
  g.price as gift_price 
from 
  children c 
  join gifts g on c.child_id = g.child_id 
where 
  g.price > (
    SELECT 
      AVG(price) 
    FROM 
      gifts
  ) --Cleaner then hardcoding the result of running this query previously
order by 
  gift_price asc