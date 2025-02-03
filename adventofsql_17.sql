with recursive time_windows as ( -- Use recursive CTE to create a table of 30 minute time windows
  select 
    '00:00:00' :: time as time_window --Anchor
  union 
  select 
    time_window + INTERVAL '30 minutes' -- Add 30 minutines to each time_window
  from 
    time_windows 
  where 
    time_window <= '23:00:00' :: time -- Untill 23:00
), 
workshop_hours as ( -- CTE containing workshops data with UTC timezones
  select 
    w.workshop_id, 
    w.workshop_name, 
    w.business_start_time - utc_offset as utc_start_time, -- Convert all business hours to UTC
    w.business_end_time - utc_offset as utc_end_time 
  from 
    workshops w 
    inner join pg_timezone_names pgt on w.timezone = pgt.name -- Postgre view containing timezones and utc_offset for conversion purposes
) 
select 
  time_window, 
  count(*) as available_workshops 
from 
  time_windows tw cross 
  join workshop_hours wh 
where 
  tw.time_window BETWEEN wh.utc_start_time -- Find meeting windows suitable for all start times
  AND (
    wh.utc_end_time - INTERVAL '1 hour' -- Subtract 1 hour as meeting must last that long without overrunning business end time
  ) 
group by 
  time_window 
order by 
  available_workshops desc, -- Find window with most available workshops
  time_window asc -- Find earliest meeting window as per task instructions
