select 
  an.tipo_animal,
  split_part(ad.data::text,'-',2) || '-' || split_part(ad.data::text,'-',1) as mes_ano, 
  count(*) as td_adocao 
from clientes c 
inner join adocoes ad on c.id = ad.id_cliente 
inner join animais an on ad.id_animal = an.id
group by 
  an.tipo_animal,
  split_part(ad.data::text,'-',1), -- agrupa pelo ano
  split_part(ad.data::text,'-',2)  -- agrupa pelo mês
order by 
  split_part(ad.data::text,'-',1), -- ordena pelo ano (crescente)
  split_part(ad.data::text,'-',2), -- ordena pelo mês (crescente)
  an.tipo_animal;
