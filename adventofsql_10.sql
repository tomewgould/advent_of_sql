-- No PIVOT function in PostgreSQL. Instead we can use the FILTER function which lets us sum records when grouping by a field(s).
with pivot as (
	select
		date,
	    sum(quantity) filter (where drink_name = 'Eggnog') as "Eggnog",
	    sum(quantity) filter (where drink_name = 'Baileys') as "Baileys",
	    sum(quantity) filter (where drink_name = 'Peppermint Schnapps') as "Peppermint Schnapps",
	    sum(quantity) filter (where drink_name = 'Sherry') as "Sherry",
	    sum(quantity) filter (where drink_name = 'Hot Cocoa') as "Hot Cocoa",
	    sum(quantity) filter (where drink_name = 'Mulled wine') as "Mulled wine"
	from drinks
	group by date
 )
 SELECT
 	date
 FROM
 	pivot
 where
 	"Hot Cocoa" = 38 AND "Peppermint Schnapps" = 298 AND "Eggnog" = 198;