WITH recursive employee_manager_cte as (
  --recursive needed in postgresql
  SELECT 
    staff_id, 
    staff_name, 
    manager_id, 
    1 as level 
  FROM 
    staff 
  WHERE 
    manager_id is null --Above block is the anchor 
  UNION ALL 
  SELECT 
    s.staff_id, 
    s.staff_name, 
    s.manager_id, 
    level + 1 
  FROM 
    staff s 
    inner join employee_manager_cte r on s.manager_id = r.staff_id -- Above is the recursive expression. 
    -- On the first iteration it will query data in [staff] relative to the Anchor.
    -- This will produce a resultset, we will call it R{1} and it is JOINed to [staff]
    -- as defined by the hierarchy
    -- Subsequent "executions" of this block will reference R{n-1}
    ) 
SELECT 
  staff_name, 
  staff_id, 
  level 
FROM 
  employee_manager_cte 
ORDER BY 
  level DESC
