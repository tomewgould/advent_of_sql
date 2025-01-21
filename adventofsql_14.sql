--Will need to first parse JSON arrays in cleaning_receipts into tabular format with granularity of 1 row per receipt_id
select 
  color, 
  garment, 
  drop_off, 
  receipt_id 
from --Felt like using a subquery over a CTE
  (
    select 
      (elements ->> 'color'):: text color, 
      -- Operator ->> extracts JSON elements from an array
      (elements ->> 'garment'):: text garment, 
      (elements ->> 'drop_off'):: date drop_off, 
      (elements ->> 'receipt_id'):: text receipt_id 
    from 
      SantaRecords cross 
      join json_array_elements(cleaning_receipts :: json) elements
  ) --json_array_elements expands a JSON array to a set of JSON elements. Cross join to combine with extracted elements.
where 
  color = 'green' 
  and garment = 'suit' 
order by 
  drop_off desc


   
   