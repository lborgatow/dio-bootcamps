select region,
	sum(population)
from "populationdb"."population"
where region='Sudeste'
group by region;
