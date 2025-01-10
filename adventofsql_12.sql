SELECT 
  gift_name, 
  COUNT(g.gift_name), 
  ROUND(
    CAST(
      PERCENT_rank() OVER(
        ORDER BY 
          COUNT(g.gift_name)
      ) as NUMERIC
    ), 
    2
  ) perc 
FROM 
  gifts g 
  INNER JOIN gift_requests gr ON gr.gift_id = g.gift_id 
GROUP BY 
  gift_Name 
ORDER BY 
  perc DESC, 
  gift_Name ASC