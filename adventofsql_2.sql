with cte as(
  select 
    id, 
    chr(value) as letter 
  from 
    letters_b 
  where 
    (
      value >= 65 
      and value <= 90
    ) 
    or (
      value >= 97 
      and value <= 122
    ) 
    or (
      value in (
        32, 33, 34, 39, 40, 41, 44, 45, 46, 58, 59, 
        63
      )
    )
) 
select 
  string_agg (letter, '') decoded_message 
from 
  cte
