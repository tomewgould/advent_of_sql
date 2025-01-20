--Need to parse email_addresses from arrays into tabular format

--Start by using the UNNEST function: UNNEST takes an ARRAY and returns a table with a single row for each element in the ARRAY.

with unnested as (
  select 
    id, 
    name, 
    emails 
  from 
    contact_list, 
    unnest(email_addresses) emails
), 
domains as (
  select 
    id, 
    name, 
    split_part(emails, '@', 2) as domain --Split emails so that we just have the domains
  from 
    unnested
) 
select 
  domain, 
  count(*) as total_users 
from 
  domains 
group by 
  domain 
order by 
  total_users desc