with joined as (
  select 
    play_id, 
    duration, 
    song_title, 
    song_duration, 
    case when duration != song_duration then 1 else 0 end as skip 
  from 
    user_plays 
    left join songs on user_plays.song_id = songs.song_id
) 
select 
  song_title, 
  count(*) as plays, 
  sum(skip) as skips 
from 
  joined 
group by 
  song_title 
order by 
  plays desc, 
  skips asc
