select * 
from "populationdb"."population"
where state = 'São Paulo'
order by population desc
limit 5
