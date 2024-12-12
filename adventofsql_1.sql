with w as (
  select 
    child_id, 
    json_value(wishes, '$.first_choice') as primary_wish, 
    json_value(wishes, '$.second_choice') as backup_wish, 
    json_value(wishes, '$.colors[0]') as favourite_colour 
  from 
    wish_lists
), 
t as (
  select 
    toy_name as primary_wish, 
    case when category = 'educational' then 'Learning Workshop' when category = 'outdoor' then 'Outdoor Workshop' else 'General Workshop' end as workshop_assignment, 
    case when difficulty_to_make = 1 then 'Simple Gift' when difficulty_to_make = 2 then 'Moderate Gift' else 'Complex Gift' end as gift_complexity 
  from 
    toy_catalogue
) 
select 
  name, 
  w.primary_wish, 
  w.backup_wish, 
  w.favourite_colour, 
  t.workshop_assignment, 
  t.gift_complexity 
from 
  children c 
  inner join w on w.child_id = c.child_id 
  inner join t on t.primary_wish = w.primary_wish 
order by 
  name asc
