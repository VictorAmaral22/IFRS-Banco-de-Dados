-- Site de ROMS

--DROPS
drop table userAvaliaRom;
drop table userBaixaRom;
drop table rom;
drop table userAvaliaRom;
drop table user;
drop table rating;
drop table regiao;
drop table genero;
drop table console;

--TABLES
create table console(
    modelo int not null,
    nome varchar(50) not null,
    primary key (modelo)
);

create table genero(
    codigo integer not null,
    nome varchar(30) not null,
    primary key (codigo)
);

create table regiao(
    codigo integer not null,
    nome varchar(15) not null,
    primary key (codigo)
);

create table rating(
    numero int not null,
    texto varchar(15) not null,
    primary key (numero)
);

create table user(
    codigo integer not null,
    isAdmin boolean not null default false,
    nome varchar(20) not null,
    primary key (codigo)
);

create table rom(
    codigo integer not null,
    modelo_console int not null,
    codigo_user integer not null,
    codigo_regiao integer not null,
    codigo_genero integer not null,
    dataHora datetime not null default current_timestamp,
    nome varchar(100) not null,
    foreign key (modelo_console) references console(modelo),
    foreign key (codigo_user) references user(codigo),
    foreign key (codigo_regiao) references regiao(codigo),
    foreign key (codigo_genero) references genero(codigo),
    primary key (codigo)
);

create table userBaixaRom(
    codigo integer not null,
    codigo_rom integer not null,
    codigo_user integer not null,
    dataHora datetime default current_timestamp,
    foreign key (codigo_rom) references rom(codigo),
    foreign key (codigo_user) references user(codigo),
    primary key (codigo, codigo_rom, codigo_user)
);

create table userAvaliaRom(
    codigo_rom integer not null,
    codigo_user integer not null,
    codigo_rating int not null,
    dataHora datetime default current_timestamp,
    foreign key (codigo_rom) references rom(codigo),
    foreign key (codigo_user) references user(codigo),
    foreign key (codigo_rating) references rating(numero),
    primary key (codigo_rom, codigo_user)
);

--INSERTS

-- Consoles
insert into console (modelo, nome) values (12345, 'Super Nintendo'),(23456, 'Game Boy');
-- Regiões
insert into regiao (nome) values ('USA'),('Europa'),('Japão');
-- Gêneros
insert into genero (nome) values ('Plataforma'),('Corrida'),('RPG');
-- Ratings
insert into rating (numero, texto) values (1,'1 estrela'),(2,'2 estrelas'),(3,'3 estrelas'),(4,'4 estrelas'),(5,'5 estrelas');
-- Usuários
insert into user (isAdmin, nome) values (True, 'Admin'),(False, 'Anonymous');

--ROMS
insert into rom (codigo_user, nome, codigo_genero, codigo_regiao, modelo_console) values (1, 'Super Mário World', 1, 1, 12345), (1, 'Super Mário World', 1, 2, 12345), (1, 'Super Mário World', 1, 3, 12345), (1, 'Super Mário Kart', 2, 1, 12345), (1, 'Super Mário Kart', 2, 2, 12345), (1, 'Super Mário Kart', 2, 3, 12345), (1, 'Pokemon Yellow', 3, 1, 23456), (1, 'Pokemon Yellow', 3, 2, 23456), (1, 'Pokemon Yellow', 3, 3, 23456);

--Downloads
insert into userBaixaRom (codigo, codigo_user, codigo_rom) values (1, 2, 1),(2, 2, 4),(3, 2, 7);

--Avaliações
insert into userAvaliaRom (codigo_user, codigo_rom, codigo_rating) values (2, 1, 4), (2, 4, 5), (2, 7, 3);
