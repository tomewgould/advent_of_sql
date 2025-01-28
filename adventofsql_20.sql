with unnested as (
  select 
    url, 
    split_part(
      unnest(
        string_to_array(
          split_part(url, '?', 2), 
          '&'
        )
      ), 
      '=', 
      1
    ) as elem 
  from 
    web_requests 
  where 
    url like '%utm_source=advent-of-sql%'
) 
select 
  url, 
  count(distinct elem) 
from 
  unnested 
group by 
  url 
order by 
  2 desc, 
  url;