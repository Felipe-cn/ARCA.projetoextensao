select 
  an.tipo_animal, 
  count(*) as qtd_castracao_agendada 
from castracoes c 
inner join animais an on c.id_animal = an.id
group by 
  an.tipo_animal
