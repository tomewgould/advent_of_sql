/*
Could not complete challenge as dataset is too large for dbfiddle.com to handle
Solution taken from u/dannywinrow
Added my comments to understand solution
*/

SELECT 
  toy_id, 
  (
    SELECT 
      COUNT(*) 
    FROM 
      (
        SELECT 
          UNNEST(new_tags) -- Parse array into rows
        EXCEPT -- Returns rows from the first query that are not in the second query
        SELECT 
          UNNEST(previous_tags)
      ) a
  ) AS added, 
  (
    SELECT 
      COUNT(*) 
    FROM 
      (
        SELECT 
          UNNEST(previous_tags) 
        INTERSECT -- Combines the result sets of two SELECT statements into a single result set. I.E. tags that have been unchanged
        SELECT 
          UNNEST(new_tags)
      ) a
  ) AS unchanged, 
  (
    SELECT 
      COUNT(*) 
    FROM 
      (
        SELECT 
          UNNEST(previous_tags) 
        EXCEPT -- Repeat to find other side of venn diagram
        SELECT 
          UNNEST(new_tags)
      ) a
  ) AS removed 
FROM 
  toy_production 
ORDER BY 
  added DESC 
LIMIT 
  1;
