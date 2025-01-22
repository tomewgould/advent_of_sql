--Need to parse the coordinates and then find the intersection between sleigh_location point and areas polygons
--Schema SQL is using PostGIS data types to store coordinates (geography)
with s as ( --Begin by using CTEs to join sleigh_locations and areas tables with a dummy join column
  select 
    coordinate, 
    1 as 
    join 
  from 
    sleigh_locations
), 
a as (
  select 
    place_name, 
    polygon, 
    1 as 
    join 
  from 
    areas
), 
joined as (
  select 
    place_name, 
    polygon, 
    coordinate, 
    st_intersects(coordinate, polygon) as intersects --st_intersects returns true if two geometries intersect, i.e. the coordinate is within a polygon
  from 
    a 
    left join s on s.join = a.join
) 
select 
  place_name 
from 
  joined 
where 
  intersects = 't'
