-- Facebook

--DROP
drop table reagePost;
drop table assuntoPost;
drop table perfilCitado;
drop table post;
drop table perfilPagina;
drop table pagina;
drop table perfilGrupo;
drop table grupo;
drop table amigo;
drop table perfil;
drop table cidade;
drop table estado;
drop table reacao;
drop table assunto;
drop table pais;

--TABLES

create table pais(
    codigo integer not null,
    nome varchar(50) not null,
    primary key(codigo)
);
insert into pais (codigo, nome) values (1,'Brasil');

create table assunto(
    codigo integer not null,
    nome varchar(30) not null,
    primary key(codigo)
);
insert into assunto (codigo, nome) values 
    (1, 'BD'),
    (2, 'SQLite'),
    (3, 'INSERT'),
    (4, 'Atendimento');

create table reacao(
    codigo integer not null,
    nome varchar(20),
    primary key(codigo)
);
insert into reacao (nome) values 
    ('Like'),
    ('Haha'),
    ('Amei'),
    ('Wow'),
    ('Grr'),
    ('Triste');

--  localização
create table estado(
    uf char(2) not null,
    pais integer not null,
    sigla char(2) not null,
    nome varchar(50) not null,
    foreign key(pais) references pais(codigo),
    primary key(uf, pais)
);
insert into estado (uf, pais, sigla, nome) values (10, 1, 'RS', 'Rio Grande do Sul');

create table cidade(
    municipio char(7) not null,
    estado char(2) not null,
    pais integer not null,
    nome varchar(50) not null,
    foreign key(estado, pais) references estado(uf, pais),
    primary key(municipio, estado, pais)
);
insert into cidade (municipio, estado, pais, nome) values (1234567, 10, 1, 'Rio Grande');

--  perfil
create table perfil(
    codigo integer not null,
    cidade char(7) not null,
    estado char(2) not null,
    pais integer not null,
    nome varchar(100) not null,
    dataHora datetime not null default current_timestamp, 
    foreign key(cidade, estado, pais) references cidade(municipio, estado, pais),
    primary key(codigo)
);
insert into perfil (cidade, estado, pais, nome, dataHora) values 
    (1234567, 10, 1, 'Professor de BD', '2010-01-01 09:00:00'),
    (1234567, 10, 1, 'João Silva Brasil', '2020-01-01 13:00:00'),
    (1234567, 10, 1, 'Pedro Alencar Pereira', '2020-01-01 13:05:00'),
    (1234567, 10, 1, 'Maria Cruz Albuquerque', '2020-01-01 13:10:00'),
    (1234567, 10, 1, 'Joana Rosa Medeiros', '2020-01-01 13:15:00'),
    (1234567, 10, 1, 'Paulo Xavier Ramos', '2020-01-01 13:20:00');
insert into perfil (cidade, estado, pais, nome) values (1234567, 10, 1, 'IFRS Campus Rio Grande');

create table amigo(
    perfil integer not null,
    perfil_amigo integer not null,
    dataHora datetime not null default current_timestamp,
    foreign key(perfil) references perfil(codigo),
    foreign key(perfil_amigo) references perfil(codigo),
    primary key(perfil, perfil_amigo)
);
insert into amigo (perfil, perfil_amigo, dataHora) values
    (1, 2, '2021-05-17 10:00:00'),
    (2, 1, '2021-05-17 10:00:00'),
    (1, 3, '2021-05-17 10:05:00'),
    (3, 1, '2021-05-17 10:05:00'),
    (1, 4, '2021-05-17 10:10:00'),
    (4, 1, '2021-05-17 10:10:00'),
    (1, 5, '2021-05-17 10:15:00'),
    (5, 1, '2021-05-17 10:15:00'),
    (1, 6, '2021-05-17 10:20:00'),
    (6, 1, '2021-05-17 10:20:00');

--  grupos/paginas
create table grupo(
    codigo integer not null,
    perfil_criador integer not null,
    nome varchar(100) not null,
    foreign key(perfil_criador) references perfil(codigo),
    primary key(codigo)
);
create table perfilGrupo(
    grupo integer not null,
    perfil_participante integer not null,
    foreign key(grupo) references grupo(codigo),
    foreign key(perfil_participante) references perfil(codigo),
    primary key(grupo, perfil_participante)
);

create table pagina(
    codigo integer not null,
    perfil_adm integer not null,
    nome varchar(100) not null,
    foreign key(perfil_adm) references perfil(codigo),
    primary key(codigo)
);
create table perfilPagina(
    pagina integer not null,
    perfil_participante integer not null,
    foreign key(pagina) references pagina(codigo),
    foreign key(perfil_participante) references perfil(codigo),
    primary key(pagina, perfil_participante)
);

--  posts
create table post(
    codigo integer not null,
    perfil integer not null,
    cidade char(7) not null,
    estado char(2) not null,
    pais integer not null,
    dataHora datetime not null default current_timestamp,
    texto varchar(500) not null,
    postComentado integer,
    postCompart integer,
    foreign key(perfil) references perfil(codigo),
    foreign key(cidade, estado, pais) references cidade(municipio, estado, pais),
    foreign key(postComentado) references post(codigo),
    foreign key(postCompart) references post(codigo),
    primary key(codigo)
);

create table perfilCitado (
    post integer not null,
    perfil_citado integer not null,
    foreign key(post) references post(codigo),
    foreign key(perfil_citado) references perfil(codigo),
    primary key(post, perfil_citado)
);

--  assuntos
create table assuntoPost(
    assunto integer not null,
    post integer not null,
    foreign key(assunto) references assunto(codigo),
    foreign key(post) references post(codigo),
    primary key(assunto, post)
);

--  reações
create table reagePost(
    post integer not null,
    perfil integer not null,
    reacao integer not null,
    dataHora datetime not null default current_timestamp,
    foreign key(post) references post(codigo),
    foreign key(perfil) references perfil(codigo),
    foreign key(reacao) references reacao(codigo),
    primary key(post, perfil)
);

--INSERTS
insert into post (perfil, cidade, estado, pais, dataHora, texto) values (2, 1234567, 10, 1, '2021-06-02 15:00:00', 'Hoje eu aprendi como inserir dados no SQLite no IFRS');
insert into assuntoPost (assunto, post) values (1, 1),(2, 1);
insert into perfilCitado (post, perfil_citado) values (1, 7);

insert into reagePost (post, perfil, reacao, dataHora) values (1, 3, 1, '2021-06-02 15:05:00');
insert into reagePost (post, perfil, reacao, dataHora) values (1, 4, 1, '2021-06-02 15:10:00');

insert into post (perfil, cidade, estado, pais, dataHora, texto, postComentado) values (5, 1234567, 10, 1, '2021-06-02 15:15:00', 'Alguém mais ficou com dúvida no comando INSERT?', 1);
insert into assuntoPost (assunto, post) values (1, 2),(2, 2),(3, 2);

insert into post (perfil, cidade, estado, pais, dataHora, texto, postComentado) values (6, 1234567, 10, 1, '2021-06-02 15:20:00', 'Eu também', 2);
insert into reagePost (post, perfil, reacao, dataHora) values (2, 6, 6, '2021-06-02 15:20:00');

insert into post (perfil, cidade, estado, pais, dataHora, texto, postComentado) values (2, 1234567, 10, 1, '2021-06-02 15:30:00', 'Já agendaste horário de atendimento com o professor?', 3);
insert into assuntoPost (assunto, post) values (4, 4),(1, 4);

insert into post (perfil, cidade, estado, pais, dataHora, texto) values (1, 1234567, 10, 1, '2021-06-02 15:35:00', 'Atendimento de BD no GMeet amanhã para quem tiver dúvidas de INSERT');
insert into assuntoPost (assunto, post) values (4, 5),(1, 5),(2, 5),(3, 5);
insert into perfilCitado (post, perfil_citado) values (5, 5),(5, 6);

insert into post (perfil, cidade, estado, pais, dataHora, texto, postCompart) values (2, 1234567, 10, 1, '2021-06-02 15:40:00', 'Atendimento de BD no GMeet amanhã para quem tiver dúvidas de INSERT', 5);
