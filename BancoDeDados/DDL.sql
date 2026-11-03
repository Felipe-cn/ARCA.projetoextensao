create table telefone (
	id serial not null,
	ddd varchar(3),
	numero varchar(9),
	constraint pk_telefone
		primary key (id)
);
create table endereco (
	id serial not null,
	cep varchar(8),
	numero varchar(3),
	constraint pk_endereco
		primary key (id)
);
CREATE TABLE cliente (
	id serial NOT NULL,
	email varchar(50),
	nome varchar(50),
	cpf varchar(11),
	tipo_residencia varchar(100),
	id_endereco int,
	id_telefone int,
	CONSTRAINT pk_cliente
		PRIMARY KEY (id),
	constraint fk_cliente_endereco
		foreign key (id_endereco)
		references endereco(id),
	constraint fk_cliente_telefone
		foreign key (id_telefone)
		references telefone(id)
);
create table funcionario (
	id serial not null,
	nome varchar(50),
	cpf varchar(11),
	id_telefone int,
	constraint pk_func
		primary key (id),
	constraint fk_funcionario_telefone
		foreign key (id_telefone)
		references telefone(id)
);
create table adm (
	id_funcionario int,
	auth smallint,
	constraint pk_adm
		primary key (id_funcionario),
	constraint fk_adm_funcionario
		foreign key (id_funcionario)
		references funcionario(id)
);
create table castrador (
	id_funcionario int,
	id_endereco int,
	constraint fk_castrador_endereco
		foreign key (id_endereco)
		references endereco(id),
	constraint fk_castrador_funcionario
		foreign key (id_funcionario)
		references funcionario(id),
	constraint pk_castrador
		primary key (id_funcionario)
);
create table denuncia (
	id serial,
	descricao text,
	data timestamp,
	andamento varchar(20),
	id_cliente int null,
	constraint pk_denuncia
		primary key (id),
	constraint fk_denuncia_cliente
		foreign key (id_cliente)
		references cliente(id)
);
create table animal (
	id serial,
	nome varchar(30),
	tipo_animal varchar(10),
	data_nascimento date,
	raca varchar(20),
	porte varchar(10),
	sexo varchar(15),
	descricao text null,
	id_cliente int null,
	constraint pk_animal
		primary key (id),
	constraint fk_animal_cliente
		foreign key (id_cliente)
		references cliente(id)
);
create table castracao (
	id serial,
	tipo_animal varchar(10),
	data date,
	porte varchar(10),
	sexo varchar(15),
	id_animal int,
	id_cliente int,
	id_castrador int,
	constraint pk_castracao
		primary key (id),
	constraint fk_castracao_animal
		foreign key (id_animal)
		references animal(id),
	constraint fk_animal_cliente
		foreign key (id_cliente)
		references cliente(id),
	constraint fk_animal_castrador
		foreign key (id_castrador)
		references castrador(id_funcionario)
);
create table adocao (
	id serial,
	data date,
	id_cliente int,
	id_animal int,
	constraint pk_adocao
		primary key (id),
	constraint fk_adocao_cliente
		foreign key (id_cliente)
		references cliente(id),
	constraint fk_adocao_animal
		foreign key (id_animal)
		references animal(id)
);
alter table endereco 
	add column referencia varchar(100) null;
alter table denuncia 
	add column id_endereco int,
	add column tipo_animal varchar(20),
	add constraint fk_denuncia_endereco
		foreign key (id_endereco)
		references endereco(id);


alter table funcionario rename to funcionarios;
alter table endereco rename to enderecos;
alter table adm rename to adms;
alter table adocao rename to adocoes;
alter table animal rename to animais;
alter table castracao rename to castracoes;
alter table castrador rename to castradores;
alter table cliente rename to clientes;
alter table denuncia rename to denuncias;
alter table telefone rename to telefones;
