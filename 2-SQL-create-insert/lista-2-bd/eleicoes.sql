-- Eleições

--DROP
drop table voto;
drop table candidato;
drop table naoVotou;
drop table eleitor;
drop table partido;
drop table cargo;
drop table secao;
drop table zona;
drop table cidade;
drop table tribunalEleitoral;

--TABLES
create table tribunalEleitoral (
    codigo integer not null,
    nome varchar(6),
    primary key(codigo)
);

create table cidade (
    codigo_municip char(7) not null,
    tribunal integer not null,
    nome varchar(30),
    foreign key (tribunal) references tribunalEleitoral(codigo),
    primary key (codigo_municip)
);

create table zona (
    --codigo integer not null,
    cidade char(7) not null,
    codigo_zona char(3) not null,
    foreign key (cidade) references cidade(codigo_municip),
    primary key (cidade, codigo_zona)
    --UNIQUE (cidade, codigo_zona)
);

create table secao (
    --codigo integer not null,
    secao char(3) not null,
    zona char(3) not null,
    cidade char(7) not null,
    foreign key (cidade, zona) references zona(cidade, codigo_zona),
    --foreign key (zona) references zona(codigo),
    primary key (secao, zona, cidade)
    --UNIQUE (secao, cidade)
);

create table cargo (
    codigo integer not null,
    tribunal integer not null,
    nome varchar(20) not null,
    dataTurnoUm date not null default current_timestamp,
    dataTurnoDois date not null default current_timestamp,
    foreign key (tribunal) references tribunalEleitoral(codigo),
    primary key (codigo),
    check (dataTurnoUm < dataTurnoDois)
);

create table partido (
    legenda char(2) not null,
    tribunal integer not null,
    sigla varchar(3),
    nome varchar(20),
    foreign key (tribunal) references tribunalEleitoral(codigo),
    primary key (legenda)
);

create table eleitor (
    tit_eleitor char(5) not null,
    tribunal integer not null,
    nome varchar(30) not null,
    genero char(1) check(genero = 'm' or genero = 'f'),
    dataNascimento date,
    secao char(3),
    zona char(3),
    cidade char(7),
    isCandidato boolean,
    foreign key (tribunal) references tribunalEleitoral(codigo),
    foreign key (secao, cidade, zona) references secao(secao, zona, cidade),
    primary key (tit_eleitor)
);

create table naoVotou (
    eleitor char(5) not null,
    cargo integer not null,
    turnoUm boolean,
    turnoDois boolean,
    dataHora datetime not null default current_timestamp,
    foreign key (eleitor) references eleitor(tit_eleitor),
    foreign key (cargo) references cargo(codigo),
    primary key (eleitor, cargo)
);

create table candidato (
    tit_eleitor char(5) not null,
    cargo integer not null,
    partido char(2) not null,
    numero varchar(4) not null,
    foreign key (tit_eleitor) references eleitor(tit_eleitor),
    foreign key (cargo) references cargo(codigo),
    foreign key (partido) references partido(legenda),
    primary key (tit_eleitor)
);

create table voto (
    cargo integer not null,
    eleitor char(5) not null,
    dataHora datetime not null default current_timestamp,
    candidato char(5),
    votoBranco boolean,
    numero varchar(4),
    foreign key (cargo) references cargo(codigo),
    foreign key (eleitor) references eleitor(tit_eleitor),
    foreign key (candidato) references candidato(tit_eleitor),
    primary key (cargo, eleitor)
);

--INSERTS
insert into tribunalEleitoral (nome) values ('TSE'),('TRE-RS');

insert into cidade (codigo_municip, tribunal, nome) values 
    ('1234567', 2, 'Rio Grande'),
    ('2345678', 2, 'São José do Norte');

insert into zona (cidade, codigo_zona) values
    ('1234567', '123'), --1 zona 123, Rio Grande
    ('1234567', '456'), --2 zona 456, Rio Grande
    ('1234567', '789'), --3 zona 789, Rio Grande
    ('2345678', '123'), --4 zona 123, São José do Norte
    ('2345678', '456'); --5 zona 456, São José do Norte

insert into secao (secao, cidade, zona) values
    ('001', '1234567', '123'), --1 seção 001, zona 123, Rio Grande
    ('002', '1234567', '123'), --2 seção 002, zona 123, Rio Grande
    ('003', '1234567', '456'), --3 seção 003, zona 456, Rio Grande
    ('004', '1234567', '789'), --4 seção 004, zona 789, Rio Grande
    ('001', '2345678', '123'), --5 seção 001, zona 123, São José do Norte
    ('002', '2345678', '456'); --6 seção 002, zona 456, São José do Norte

insert into cargo (tribunal, nome, dataTurnoUm, dataTurnoDois) values
    (1, 'Prefeito', '2021-10-10', '2021-10-31'),
    (1, 'Vereador', '2021-10-10', '2021-10-31'),
    (1, 'Deputado Estadual', '2021-10-10', '2021-10-31');

insert into partido (legenda, tribunal, sigla, nome) values
    (12, 2, 'ABC', 'Partido ABC'),
    (34, 2, 'DEF', 'Partido DEF'),
    (56, 2, 'GHI', 'Partido GHI'),
    (78, 2, 'JKL', 'Partido JKL');

--deputados estaduais
insert into eleitor (tit_eleitor, tribunal, nome, isCandidato) values
    (00012, 2, 'Ana Bragança Rocha', true),
    (00389, 2, 'Paulo Silva Mendes', true),
    (00419, 2, 'Maria Medeiros Oliveira', true),
    (00551, 2, 'Carlos Ávila Machado', true),
    (00865, 2, 'Carolina Xavier Silva', true);

--eleitores que são candidatos/prefeitos rg
insert into eleitor (tit_eleitor, tribunal, nome, genero, dataNascimento, cidade, zona, secao, isCandidato) values
    (10982, 2, 'João Silva Brasil', 'm', '1991-03-06', 1234567, 3, 2, true),
    (13613, 2, 'Maria Pereira Braz', 'f',
    '1991-09-09', 1234567, 2, 1, true),
    (15334, 2, 'Pedro Barros Oliveira', 'm', '1996-01-15', 1234567, 4, 3, true),
    (24997, 2, 'Julia Rosa Andrade', 'f', '1998-10-17', 1234567, 4, 3, true);

--prefeitos S. José do N.
insert into eleitor (tit_eleitor, tribunal, nome, cidade, isCandidato) values
    (12543, 2, 'Maria Vilas Oliveira', 2345678, true),
    (22987, 2, 'Carlos Jardim Lemos', 2345678, true);

--vereadores
insert into eleitor (tit_eleitor, tribunal, nome, cidade, isCandidato) values
    --Rio Grande
    (16850, 2, 'Vitor Braga Nunes', 1234567, true),
    (19814, 2, 'Felipe Rosa Andrade', 1234567, true),
    (29883, 2, 'Milena Alves Rodriguez', 1234567, true),
    (30979, 2, 'Alexandre Santos Brasil', 1234567, true),
    (36546, 2, 'Luciano Mendes Ávila', 1234567, true),
    (40485, 2, 'Tiago Oliveira Bezerra', 1234567, true),
    --São José do Norte
    (17934, 2, 'Rodrigo Domingues Souto', 2345678, true),
    (12580, 2, 'Gustavo Souza Braga', 2345678, true);

--candidatos
insert into candidato (tit_eleitor, cargo, partido, numero) values
    --dep estadual
    (00012, 3, 12, 120), --Ana Bragança Rocha
    (00389, 3, 12, 121), --Paulo Silva Mendes
    (00419, 3, 34, 340), --Maria Medeiros Oliveira
    (00551, 3, 56, 561), --Carlos Ávila Machado
    (00865, 3, 78, 780), --Carolina Xavier Silva
    --prefeitura rg
    (10982, 1, 12, 12),  --João Silva Brasil
    (13613, 1, 34, 34),  --Maria Pereira Braz
    (15334, 1, 56, 56),  --Pedro Barros Oliveira
    --prefeitura sjn
    (12543, 1, 12, 12),  --Maria Vilas Oliveira
    (22987, 1, 56, 56),  --Carlos Jardim Lemos
    --vereadores rg
    (16850, 2, 12, 1200),  --Vitor Braga Nunes
    (19814, 2, 12, 1205),  --Felipe Rosa Andrade
    (24997, 2, 34, 3401),  --Julia Rosa Andrade
    (29883, 2, 56, 5603),  --Milena Alves Rodriguez
    (30979, 2, 56, 5607),  --Alexandre Santos Brasil
    (36546, 2, 78, 7802),  --Luciano Mendes Ávila
    (40485, 2, 78, 7809),  --Tiago Oliveira Bezerra
    --vereadores sjn
    (17934, 2, 12, 1200),  --Rodrigo Domingues Souto
    (12580, 2, 56, 5601);  --Gustavo Souza Braga

--1o Turno

--João Silva Brasil
insert into voto (cargo, eleitor, dataHora, candidato, numero) values (3, 10982, '2021-10-10 15:00:00', 00551, 00561);
insert into voto (cargo, eleitor, dataHora, candidato, numero) values (1, 10982, '2021-10-10 15:00:00', 10982, 12);
insert into voto (cargo, eleitor, dataHora, votoBranco) values (2, 10982, '2021-10-10 15:00:00', true);

--Maria Pereira Braz
insert into voto (cargo, eleitor, dataHora, candidato, numero) values (3, 13613, '2021-10-10 15:10:00', 00389, 121);
insert into voto (cargo, eleitor, dataHora, candidato, numero) values (1, 13613, '2021-10-10 15:10:00', 13613, 34);
insert into voto (cargo, eleitor, dataHora) values (2, 13613, '2021-10-10 15:10:00');

--Pedro Barros Oliveira
insert into voto (cargo, eleitor, dataHora, votoBranco) values (3, 15334, '2021-10-10 15:20:00', true);
insert into voto (cargo, eleitor, dataHora, candidato, numero) values (1, 15334, '2021-10-10 15:20:00', 15334, 56);
insert into voto (cargo, eleitor, dataHora, candidato, numero) values (2, 15334, '2021-10-10 15:20:00', 24997, 3401);

--Julia Rosa Andrade
insert into naoVotou (eleitor, cargo, turnoUm, dataHora) values 
    (24997, 1, true, '2021-10-12 14:10:00'),
    (24997, 2, true, '2021-10-12 14:10:00'),
    (24997, 3, true, '2021-10-12 14:10:00');
