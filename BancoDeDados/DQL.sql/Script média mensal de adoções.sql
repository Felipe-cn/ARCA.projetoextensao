select 
	mes_ano,
	round(avg(total_castracoes), 2) as media_mensal_de_castracoes
from (
	select 
		split_part(data::text,'-',2) || '-' || split_part(data::text,'-',1) as mes_ano,
		split_part(data::text,'-',1) as ano,
		split_part(data::text,'-',2) as mes,
		count(*) as total_castracoes
	from castracoes
	group by split_part(data::text,'-',1), split_part(data::text,'-',2)
)
group by ano, mes, mes_ano
order by ano, mes
