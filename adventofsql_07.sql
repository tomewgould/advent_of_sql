/*
Could not complete challenge as dataset is too large for dbfiddle.com to handle
Solution taken from u/lern_by
Added my comments to understand solution
*/

SELECT 
  DISTINCT FIRST_VALUE(elf_id) OVER ( -- FIRST_VALUE returns the value from the first row of a partitioned result set
    PARTITION BY primary_skill -- Group by primary_skill to find the elves with the min and max years_experience for each 
    ORDER BY 
      years_experience DESC, -- DESC order will return the max value in the first row for first_value to pick up
      elf_id -- order by elf_id to deal with duplicates as per task instructions
  ) AS max_id, 
  FIRST_VALUE(elf_id) OVER (
    PARTITION BY primary_skill 
    ORDER BY 
      years_experience, -- ASC order will return the min value in the first row for first_value to pick up
      elf_id
  ) AS min_id, 
  primary_skill 
FROM 
  workshop_elves 
ORDER BY 
  max_id, 
  min_id;
