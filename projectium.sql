/**
	Aplicação:               	SISGEPRO - Sistema Gerenciador de Projetos
	Nome Fantasia:				Projectium
	Data: 						18/09/2025
	Demanda: 					PROJECTIUM20250918121422DTB
	Objetivo:  					Modelar a funcionalidade de gerenciador de Autenticação
*/

create extension if not exists pgcrypto;

drop table if exists tb_categoria_pessoa cascade;
drop table if exists tb_pessoa cascade;
drop table if exists tb_perfil cascade;
drop table if exists tb_usuario cascade;
drop table if exists tb_usuario_perfil cascade;

create table if not exists tb_categoria_pessoa (
	code bigserial not null,
	code_public varchar(255) not null default gen_random_uuid(),
	descricao varchar(255) not null,
	sigla varchar(4) not null,
	data_criacao timestamp default current_timestamp,
	data_atualizacao timestamp default current_timestamp,
	data_delecao timestamp,
	usuario_operacao varchar(255) null,
	active boolean not null default true,
	constraint pk_categoria_pessoa primary key (code)
);

create table if not exists tb_pessoa (
	code bigserial not null,
	code_public varchar(255) not null default gen_random_uuid(),
	id_categoria_pessoa serial not null,
	nome varchar(255) not null,
	data_criacao timestamp default current_timestamp,
	data_atualizacao timestamp default current_timestamp,
	data_delecao timestamp,
	usuario_operacao varchar(255) null,
	active boolean not null default true,
	constraint pk_pessoa primary key (code),
	constraint fk_categoria_pessoa foreign key (id_categoria_pessoa) references tb_categoria_pessoa (code)
);

create table if not exists tb_perfil (
	code bigserial not null,
	code_public varchar(255) not null default gen_random_uuid(),
	descricao varchar(255) not null,
	data_criacao timestamp default current_timestamp,
	data_atualizacao timestamp default current_timestamp,
	data_delecao timestamp,
	usuario_operacao varchar(255) null,
	active boolean not null default true,
	constraint pk_perfil primary key (code)
);

create table if not exists tb_usuario (
	code bigserial not null,
	code_public varchar(255) not null default gen_random_uuid(),
	usuario varchar(255) not null,
	senha varchar(255) not null,
	data_criacao timestamp default current_timestamp,
	data_atualizacao timestamp default current_timestamp,
	data_delecao timestamp,
	usuario_operacao varchar(255) null,
	active boolean not null default true,
	constraint pk_usuario primary key (code)
);

create table if not exists tb_usuario_perfil (
	code bigserial not null,
	id_usuario serial not null,
	id_perfil serial not null,
	data_criacao timestamp default current_timestamp,
	data_atualizacao timestamp default current_timestamp,
	data_delecao timestamp,
	usuario_operacao varchar(255) null,
	active boolean not null default true,
	constraint pk_usuario_perfil primary key (code)
);

-- Inserts
insert into tb_categoria_pessoa (descricao, sigla) values ('Pessoa Física', 'PF'), ('Pessoa Jurídica', 'PJ');

insert into tb_pessoa (id_categoria_pessoa, nome) values (1, 'Kuipeunt Ustes Wyoquelas');

insert into tb_perfil (descricao) values 
	('Administrador'), 
	('Gerente de Projetos'),
	('Cliente'),
	('Analista de Sistemas'),
	('Analista de Qualidade'),
	('Analista de Infraestrutura'),
	('Analista de Interface');

insert into tb_usuario (usuario, senha) values ('kuipeunt.wyoquelas@projectium.com.br', 'f9c1c5dcf025033fe6b759f378ef0597');

insert into tb_usuario_perfil (id_usuario, id_perfil) values (1, 1);

-- Consultas
select * from tb_categoria_pessoa;

select * from tb_pessoa;

select * from tb_perfil;

select * from tb_usuario;

select * from tb_usuario_perfil;

/**
	Aplicação:               	SISGEPRO - Sistema Gerenciador de Projetos
	Nome Fantasia:				Projectium
	Data: 						18/09/2025
	Demanda: 					PROJECTIUM20250918003802DTB
	Objetivo:  					Modelar a funcionalidade de gerenciador de Projetos
*/

drop table if exists tb_situacao_projeto cascade;
drop table if exists tb_categoria_projeto cascade;
drop table if exists tb_projeto cascade;

create table if not exists tb_situacao_projeto (
	code bigserial not null,
	code_public varchar(255) not null default gen_random_uuid(),
	descricao varchar(255) not null,
	data_criacao timestamp default current_timestamp,
	data_atualizacao timestamp default current_timestamp,
	data_delecao timestamp,
	usuario_operacao varchar(255) null,
	active boolean not null default true,
	constraint pk_situacao_projeto primary key (code)
);

create table if not exists tb_categoria_projeto (
	code bigserial not null,
	code_public varchar(255) not null default gen_random_uuid(),
	descricao varchar(255) not null,
	data_criacao timestamp default current_timestamp,
	data_atualizacao timestamp default current_timestamp,
	data_delecao timestamp,
	usuario_operacao varchar(255) null,
	active boolean not null default true,
	constraint pk_categoria_projeto primary key (code)
);

create table if not exists tb_projeto (
    code bigserial not null,
    code_public uuid not null,
    id_situacao_projeto serial not null,
	id_categoria_projeto serial not null,
    nome varchar(255) not null,
	sigla varchar(255) not null,
	descricao text null,
    data_inicial date not null,
    data_final date not null,
    data_criacao timestamp default current_timestamp,
	data_atualizacao timestamp default current_timestamp,
	data_delecao timestamp,
	usuario_operacao varchar(255) null,
	active boolean not null default true,
    constraint pk_projeto primary key (code),
    constraint fk_situacao_projeto foreign key (id_situacao_projeto) references tb_situacao_projeto (code),
    constraint fk_categoria_projeto foreign key (id_categoria_projeto) references tb_categoria_projeto (code)
);