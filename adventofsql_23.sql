select 
  n.number as missing_id 
from 
  generate_series(1, 10000) as n(number) -- We know tags range from 1-10000 so we can create a full list
  left join sequence_table as t on n.number = t.id 
where 
  t.id is null -- This will return ids from the full list that are not in the table
