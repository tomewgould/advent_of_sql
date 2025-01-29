with unnested as (
  select 
    url, 
    split_part( -- Take the key of each key value pair (separated by =)
      unnest( -- Parse each element of each array into rows
        string_to_array( -- Convert string of parameters for each url into an array that is split by each &
          split_part(url, '?', 2), -- Separate the parameters from the domain
          '&'
        )
      ), 
      '=', 
      1
    ) as elem 
  from 
    web_requests 
  where 
    url like '%utm_source=advent-of-sql%' -- Filter out url values that do not include desired query parameter
) 
select 
  url, 
  count(distinct elem) -- Count number of query parameters per url
from 
  unnested 
group by 
  url 
order by 
  2 desc, 
  url;
