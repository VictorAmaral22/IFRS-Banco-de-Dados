SQLite3
	sqlite arquivo.db
		.help				ajuda
		.help COMANDO		ajuda do comando COMANDO
		.read ARQUIVO		lê e executa comandos no arquivo ARQUIVO
		.output ARQUIVO		grava saída no arquivo ARQUIVO
		.databases			lista bases de dados
		.tables				lista tabelas em uma base de dados
		.schema				mostra comandos CREATE TABLE das tabelas em uma base de dados
		.dump				backup de uma base de dados
		.quit				sair

		Configuração padrão a ser realizada antes de cada uso
			.headers on
			.mode column
			PRAGMA foreign_keys = ON;

----------------------------------------------------------------------------------------------------

Guia para importar um arquivo SQL

1) cd \pasta\onde\está\o\arquivo\sql

2) dir
meubanco.sql

3) sqlite3 meubanco.db

4) .headers on
   .mode column
   PRAGMA foreign_keys = ON;

5) .read meubanco.sql

----------------------------------------------------------------------------------------------------

Guia para uso normal

1) cd \pasta\onde\está\o\arquivo\db

2) dir
meubanco.db

3) sqlite3 meubanco.db

4) .headers on
   .mode column
   PRAGMA foreign_keys = ON;

----------------------------------------------------------------------------------------------------

SQL: Structured Query Language

	DDL: Data Definition Language
		create, alter, drop

	DML: Data Manipulation Language
		insert, delete, update

	DQL: Data Query Language
		select

----------------------------------------------------------------------------------------------------

CREATE TABLE tabela (
	campo tipo [ NOT NULL ] [ DEFAULT expressão ] [ CHECK ( expressão ) ] [, ... ] [, ]
	[ UNIQUE ( campo [, ... ] ) [, ... ] [, ] ]
	[ FOREIGN KEY ( campo [, ... ] ) REFERENCES tabela ( campo [, ... ] ) [, ... ] [, ] ]
	[ PRIMARY KEY ( campo [, ... ] ) ]
);

sintaxe
	A | B = A ou B
	[ A ] = A é opcional
	A ... = repetição de A

----------------------------------------------------------------------------------------------------

tipos de dados
	boolean			lógico
	integer			inteiro
	real			real
	char(n)			n letras, tamanho fixo, com espaços à direita
	varchar(n)		n letras, tamanho variável, sem espaços à direita
	date			data
	time			hora
	datetime		data e hora
	numeric(m,n)	número com m dígitos, sendo n dígitos decimais (numeric(5, 2) = 999.99)
	decimal(m,n)	apelido para numeric(m,n)
	auto_increment	inteiro autoincrementado

----------------------------------------------------------------------------------------------------
-- Nota Fiscal
----------------------------------------------------------------------------------------------------
-- a ordem de criação das tabelas é importante, primeiro as que não tem fk, depois as que tem fk

create table pessoa (
	cpf integer not null,
	nome varchar(100) not null,
	primary key (cpf)
);

create table empresa (
	cnpj char(14) not null check (ehcnpjvalido(cnpj)),
	nome varchar(100) not null,
	endereco varchar(100) not null,
	primary key (cnpj)
);

create table cliente (
	cpfcnpj char(14) not null check (ehcnpjvalido(cpfcnpj) or ehcpfvalido(substr(cpfcnpj, 1, 11))),
	nome varchar(100) not null,
	endereco varchar(100) not null,
	primary key (cpfcnpj)
);

create table operador (
	codigo integer not null,
	nome varchar(100) not null,
	primary key (codigo)
);

create table notafiscal (
	nserie char(6) not null,
	quando datetime not null default current_timestamp check (quando <= current_timestamp),
	empresa char(14) not null,
	cliente char(14), -- -O| PODE SER NULL!
	operador integer not null,
	foreign key (empresa) references empresa(cnpj),
	foreign key (cliente) references cliente(cpfcnpj),
	foreign key (operador) references operador(codigo),
	primary key (nserie)
);

create table produto (
	codigo integer not null,
	descricao varchar(100) not null,
	unidade varchar(3) not null,
	preco real not null check (preco > 0),
	imposto real not null check (imposto >= 0),
	primary key (codigo)
);

create table item (
	nsequencial integer not null,
	notafiscal char(6) not null,
	produto integer not null,
	quantidade real not null default 1 check (quantidade > 0),
	foreign key (notafiscal) references notafiscal(nserie),
	foreign key (produto) references produto(codigo),
	primary key (nsequencial, notafiscal)
);

----------------------------------------------------------------------------------------------------
-- Pizzaria
----------------------------------------------------------------------------------------------------
-- a ordem de criação das tabelas é importante, primeiro as que não tem fk, depois as que tem fk

create table tipo (
	codigo integer not null,
	nome varchar(100) not null,
	primary key (codigo)
);

create table sabor (
	codigo integer not null,
	nome varchar(100) not null,
	tipo integer not null,
	foreign key (tipo) references tipo(codigo),
	primary key (codigo)
);

create table ingrediente (
	codigo integer not null,
	nome varchar(100) not null,
	primary key (codigo)
);

create table saboringrediente (
	sabor integer not null,
	ingrediente integer not null,
	foreign key (sabor) references sabor(codigo),
	foreign key (ingrediente) references ingrediente(codigo),
	primary key (sabor, ingrediente)
);

create table tamanho (
	codigo char(1) not null,
	nome varchar(100) not null,
	qtdesabores integer not null check (qtdesabores > 0),
	primary key (codigo)
);

create table precoportamanho (
	tipo integer not null,
	tamanho char(1) not null,
	preco real not null check (preco > 0),
	foreign key (tipo) references tipo(codigo),
	foreign key (tamanho) references tamanho(codigo),
	primary key (tipo, tamanho)
);

create table mesa (
	codigo integer not null,
	nome varchar(100) not null,
	primary key (codigo)
);

create table comanda (
	numero integer not null,
	data date default current_date,
	mesa integer not null,
	pago boolean not null default false,
	foreign key (mesa) references mesa(codigo),
	primary key (numero)
);

create table borda (
	codigo integer not null,
	nome varchar(100) not null,
	preco real not null check (preco > 0),
	primary key (codigo)
);

create table pizza (
	codigo integer not null,
	comanda integer not null,
	tamanho char(1) not null,
	borda integer, -- -O| PODE SER NULL!
	foreign key (comanda) references comanda(numero),
	foreign key (tamanho) references tamanho(codigo),
	foreign key (borda) references borda(codigo),
	primary key (codigo)
);

create table pizzasabor (
	pizza integer not null,
	sabor integer not null,
	foreign key (pizza) references pizza(codigo),
	foreign key (sabor) references sabor(codigo),
	primary key (pizza, sabor)
);

----------------------------------------------------------------------------------------------------
-- Pessoas
----------------------------------------------------------------------------------------------------

create table pessoa (
	cpf char(11) not null check (ehcpfvalido(cpf)),
	nome varchar(100) not null check (ehnomevalido(nome)),
	nascimento date not null check (nascimento <= current_date),
	genero char(1) not null default 'M' check (genero = 'M' or genero = 'F'),
	endereco varchar(100) not null,
	telefones varchar(100),
	primary key (cpf)
);

create table funcionario (
	pessoa char(11) not null,
	admissao date not null default current_date check (admissao <= current_date)
	salario real not null check (salario > 0),
	foreign key (pessoa) references pessoa(cpf),
	primary key (pessoa)
);

create table cliente (
	pessoa char(11) not null,
	renda real not null check (renda > 0),
	foreign key (pessoa) references pessoa(cpf),
	primary key (pessoa)
);

create table cartaocredito (
	numero char(16) not null check (ehcartaocreditovalido(numero)),
	mesvalidade integer not null check (mesvalidade between 1 and 12),
	anovalidade integer not null check (anovalidade >= cast(strftime('%Y',current_date) as integer)),
	cliente char(11) not null,
	foreign key (cliente) references cliente(pessoa),
	primary key (numero)
);

----------------------------------------------------------------------------------------------------

INSERT INTO tabela [ ( campo [, ... ] ) ]
	VALUES ( expressão [, ... ] ) [, ... ] | consulta
	[ RETURNING expressão | campo [, ... ] | * ];

sintaxe
	A | B = A ou B
	[ A ] = A é opcional
	A ... = repetição de A

----------------------------------------------------------------------------------------------------

create table tabela1 (
	campo1 integer,
	campo2 real,
	campo3 varchar(100),
	campo4 date
);

insert into tabela1 (campo1, campo2, campo3, campo4) values
	(123, 123.45, 'abc', '2000-12-31'),
	(null, 234.56, 'def', '2001-12-31'),
	(345, null, 'ghi', '2002-12-31'),
	(456, 456.78, null, '2003-12-31'),
	(567, 567.89, 'mno', null),
	(null, null, null, null);

insert into tabela1 (campo1, campo2) values (678, 678.90);
-- campo3 = null
-- campo4 = null

-- erro se campos são not null

----------------------------------------------------------------------------------------------------

create table tabela2 (
	campo1 integer, -- campo integer como única chave primária é sempre autoincrementado
	campo2 real default 0,
	campo3 varchar(100),
	campo4 date default current_date,
	primary key (campo1)
);

-- returning sqlite3 >= 3.35.0

insert into tabela2 (campo2, campo3, campo4) values (123.45, 'abc', '2000-12-31') returning campo1;
-- campo1 = autoincrementado

insert into tabela2 (campo3) values ('ghi') returning campo1;
-- campo1 = autoincrementado
-- campo2 = default 0
-- campo4 = default current_date

----------------------------------------------------------------------------------------------------
-- Nota Fiscal
----------------------------------------------------------------------------------------------------

insert into empresa (cnpj, nome, endereco) values
	('12123123123412', 'EMPRESA XYZ SA', 'R. ABC, 123 - RIO GRANDE - RS');

insert into cliente (cpfcnpj, nome, endereco) values
	('12312312312   ', 'FULANO DA SILVA', 'R. DEF, 123 - RIO GRANDE - RS');

insert into operador (codigo, nome) values
	(456, 'BELTRANO BRASIL');

insert into produto (codigo, descricao, unidade, preco, imposto) values
	(12345, 'COCA COLA 2L', 'UN', 5.50, 13.00),
	(67890, 'MORTADELA', 'KG', 20.00, 11.00),
	(24680, 'PAO FRANCES', 'KG', 9.90, 7.00);

insert into notafiscal (nserie, empresa, cliente, operador) values
	('12345A', '12123123123412', '12312312312   ', 456);

insert into item (nsequencial, notafiscal, produto, quantidade) values
	(1, '12345A', 12345, 2),
	(2, '12345A', 67890, 0.150),
	(3, '12345A', 24680, 0.330);

----------------------------------------------------------------------------------------------------
-- Pizzaria
----------------------------------------------------------------------------------------------------

insert into tamanho (codigo, nome, qtdesabores) values
	('P', 'PEQUENA', 1),
	('M', 'MEDIA', 2),
	('G', 'GRANDE', 3),
	('F', 'FAMILIA', 4);

insert into tipo (codigo, nome) values
	(1, 'PIZZAS SALGADAS TRADICIONAIS'),
	(2, 'PIZZAS SALGADAS ESPECIAIS'),
	(3, 'PIZZAS DOCES TRADICIONAIS');

insert into sabor (codigo, nome, tipo) values
	(1, '3 QUEIJOS', 1),
	(2, '4 QUEIJOS', 1),
	(3, 'CHARQUE', 2),
	(4, 'BAFO', 2),
	(5, 'MORANGO', 3),
	(6, 'MACA E CANELA', 3);

insert into ingrediente (codigo, nome) values
	(1, 'ALHO'),
	(2, 'AZEITONA'),
	(3, 'BACON'),
	(4, 'CANELA'),
	(5, 'CATUPIRY'),
	(6, 'CEBOLA'),
	(7, 'CHARQUE'),
	(8, 'CHOCOLATE'),
	(9, 'GORGONZOLA'),
	(10, 'LEITE CONDENSADO'),
	(11, 'MACA'),
	(12, 'MORANGO'),
	(13, 'MUSSARELA'),
	(14, 'PROVOLONE');

insert into borda (codigo, nome, preco) values
	(1, 'CATUPIRY', 2.00),
	(2, 'PIMENTA', 4.00);

insert into mesa (codigo, nome) values
	(1, '1A');

insert into saboringrediente (sabor, ingrediente) values
	(1, 5), (1, 13), (1, 14),
	(2, 5), (2, 13), (2, 14), (2, 9),
	(3, 13), (3, 6), (3, 7),
	(4, 13), (4, 3), (4, 6), (4, 1), (4, 2),
	(5, 12), (5, 10), (5, 8),
	(6, 11), (6, 10), (6, 4);

insert into precoportamanho (tipo, tamanho, preco) values
	(1, 'P', 59.00), (1, 'M', 66.00), (1, 'G', 73.00), (1, 'F', 80.00),
	(2, 'P', 66.00), (2, 'M', 74.00), (2, 'G', 82.00), (2, 'F', 90.00),
	(3, 'P', 60.00), (3, 'M', 65.00), (3, 'G', 70.00), (3, 'F', 75.00);

insert into comanda (numero, mesa) values
	(3, 1);

insert into pizza (codigo, comanda, tamanho, borda) values
	(1, 3, 'G', 1),
	(2, 3, 'P', null);

insert into pizzasabor (pizza, sabor) values
	(1, 2), (1, 4),
	(2, 6);
