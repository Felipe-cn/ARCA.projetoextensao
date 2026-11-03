BEGIN;

-- TELEFONES
INSERT INTO telefones (ddd, numero)
SELECT 
  lpad((floor(random()*99)+1)::text, 2, '0'),
  lpad((floor(random()*999999999))::text, 9, '0')
FROM generate_series(1, 50000);

-- ENDERECOS
INSERT INTO enderecos (cep, numero, referencia)
SELECT 
  lpad((floor(random()*99999999))::text, 8, '0'),
  (floor(random()*999)+1)::text,
  'Referencia ' || g
FROM generate_series(1, 50000) g;

-- CLIENTES
INSERT INTO clientes (email, nome, cpf, tipo_residencia, id_endereco, id_telefone)
SELECT
  lower(nome_base || '.' || sobrenome || g || 
    (ARRAY['@gmail.com','@outlook.com','@hotmail.com'])[floor(random()*3)+1]),
  initcap(nome_base || ' ' || sobrenome),
  lpad((floor(random()*99999999999))::text, 11, '0'),
  (ARRAY['Casa','Apartamento'])[floor(random()*2)+1],
  (floor(random()*50000)+1)::int,
  (floor(random()*50000)+1)::int
FROM (
  SELECT 
    (ARRAY[
      'joao','maria','pedro','ana','lucas','juliana','carlos','fernanda',
      'bruno','amanda','rafael','beatriz','gustavo','camila','leonardo',
      'patricia','rodrigo','mariana','felipe','larissa'
    ])[floor(random()*20)+1] AS nome_base,
    
    (ARRAY[
      'silva','souza','oliveira','pereira','costa','rodrigues','almeida',
      'nascimento','lima','gomes','ribeiro','carvalho','martins','araujo'
    ])[floor(random()*14)+1] AS sobrenome,
    
    g
  FROM generate_series(1, 50000) g
) t;

-- FUNCIONARIOS
INSERT INTO funcionarios (nome, cpf, id_telefone)
SELECT
  initcap(nome_base || ' ' || sobrenome),
  lpad((floor(random()*99999999999))::text, 11, '0'),
  (floor(random()*50000)+1)::int
FROM (
  SELECT 
    (ARRAY[
      'joao','maria','pedro','ana','lucas','juliana','carlos','fernanda',
      'bruno','amanda','rafael','beatriz'
    ])[floor(random()*12)+1] AS nome_base,
    
    (ARRAY[
      'silva','souza','oliveira','pereira','costa','rodrigues','almeida'
    ])[floor(random()*7)+1] AS sobrenome
  FROM generate_series(1, 20000)
) t;

-- ADMS
INSERT INTO adms (id_funcionario, auth)
SELECT id, (floor(random()*5)+1)
FROM funcionarios
WHERE id <= 5000;

-- CASTRADORES
INSERT INTO castradores (id_funcionario, id_endereco)
SELECT 
  id,
  (floor(random()*50000)+1)::int
FROM funcionarios
WHERE id > 5000 AND id <= 15000;

-- ANIMAIS (RAÇAS REAIS + DESCRIÇÃO REALISTA)
INSERT INTO animais (nome, tipo_animal, data_nascimento, raca, porte, sexo, descricao, id_cliente)
SELECT
  initcap(nome_pet),
  tipo,
  CURRENT_DATE - (floor(random()*3650)) * INTERVAL '1 day',
  raca,
  porte,
  sexo,
  descricao,
  (floor(random()*50000)+1)::int
FROM (
  SELECT 
    (ARRAY[
      'thor','mel','luna','max','bella','bob','nina','toby','simba','fred',
      'jade','zeus','akira','loki','mia','rex','pandora','nick','pingo','amora'
    ])[floor(random()*20)+1] AS nome_pet,

    (ARRAY['Cachorro','Gato'])[floor(random()*2)+1] AS tipo,

    (ARRAY[
      'Vira-lata','Labrador','Poodle','Bulldog','Pastor Alemão','Golden Retriever',
      'Siamês','Persa','Maine Coon','Rottweiler','Pinscher','Shih Tzu'
    ])[floor(random()*12)+1] AS raca,

    (ARRAY['Pequeno','Médio','Grande'])[floor(random()*3)+1] AS porte,

    (ARRAY['Macho','Fêmea'])[floor(random()*2)+1] AS sexo,

    (ARRAY[
      'Animal saudável e muito ativo',
      'Resgatado recentemente, um pouco assustado',
      'Muito dócil e sociável',
      'Necessita de cuidados veterinários',
      'Brincalhão e cheio de energia',
      'Calmo e ideal para companhia',
      'Em recuperação de cirurgia',
      'Levemente desnutrido, precisa de atenção',
      'Extremamente carinhoso',
      'Assustado no início, mas se adapta rápido'
    ])[floor(random()*10)+1] AS descricao,

    g
  FROM generate_series(1, 50000) g
) t;

-- DENUNCIAS
INSERT INTO denuncias (descricao, data, andamento, id_cliente, id_endereco, tipo_animal)
SELECT
  'Denuncia ' || g,
  DATE '2026-01-01' + (floor(random() * 365) * INTERVAL '1 day'), -- Data aleatória em 2026
  (ARRAY['Aberto','Em andamento','Finalizado'])[floor(random()*3)+1],
  (floor(random()*50000)+1)::int,
  (floor(random()*50000)+1)::int,
  (ARRAY['Cachorro','Gato'])[floor(random()*2)+1]
FROM generate_series(1, 30000) g;

-- CASTRACOES
INSERT INTO castracoes (tipo_animal, data, porte, sexo, id_animal, id_cliente, id_castrador)
SELECT
  (ARRAY['Cachorro','Gato'])[floor(random()*2)+1],
  DATE '2026-01-01' + (floor(random() * 365) * INTERVAL '1 day'), -- Data aleatória em 2026
  (ARRAY['Pequeno','Médio','Grande'])[floor(random()*3)+1],
  (ARRAY['Macho','Fêmea'])[floor(random()*2)+1],
  (floor(random()*50000)+1)::int,
  (floor(random()*50000)+1)::int,
  (SELECT id_funcionario FROM castradores ORDER BY random() LIMIT 1)
FROM generate_series(1, 30000);

-- ADOCOES
INSERT INTO adocoes (data, id_cliente, id_animal)
SELECT
  DATE '2026-01-01' + (floor(random() * 365) * INTERVAL '1 day'), -- Data aleatória em 2026
  (floor(random()*50000)+1)::int,
  (floor(random()*50000)+1)::int
FROM generate_series(1, 20000);

COMMIT;
