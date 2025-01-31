/* 
Find all the elves with SQL as a skill

Count each elf only once.

Only the skill SQL counts, MySQL etc. does not count.
*/

select 
  count(*) 
from 
  elves 
where 
  'SQL' = any( -- any returns true if the comparison returns true for at least one of the values in the set
    string_to_array(skills, ',')
  ) -- Our filter condition is whether any elements in the skills array are SQL
