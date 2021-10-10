-- Facebook

--DROP
drop table reagePost;
drop table assuntoPost;
drop table perfilCitado;
drop table coment_compart;
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
    nome varchar(50),
    primary key(codigo)
);
create table assunto(
    codigo integer not null,
    nome varchar(30),
    primary key(codigo)
);
create table reacao(
    codigo integer not null,
    nome varchar(20),
    primary key(codigo)
);

--  localização
create table estado(
    uf char(2) not null,
    pais integer not null,
    sigla char(2) not null,
    nome varchar(50) not null,
    foreign key(pais) references pais(codigo),
    primary key(uf),
    UNIQUE (uf, pais)
);
create table cidade(
    municipio char(7) not null,
    estado char(2) not null,
    pais integer not null,
    sigla char(2) not null,
    nome varchar(50) not null,
    foreign key(estado) references estado(uf),
    foreign key(pais) references pais(codigo),
    primary key(municipio),
    UNIQUE (municipio, estado, pais)
);

--  perfil
create table perfil(
    codigo integer not null,
    cidade char(7) not null,
    estado char(2) not null,
    pais integer not null,
    nome varchar(100) not null,
    dataHora datetime not null default current_timestamp,
    foreign key(pais) references pais(codigo),    
    foreign key(estado) references estado(uf),    
    foreign key(cidade) references cidade(municipio),
    primary key(codigo)
);
create table amigo(
    perfil integer not null,
    perfil_amigo integer not null,
    dataHora datetime not null default current_timestamp,
    foreign key(perfil) references perfil(codigo),
    foreign key(perfil_amigo) references perfil(codigo),
    primary key(perfil, perfil_amigo)
);

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
    dataHora datetime not null default current_timestamp,
    texto varchar(500) not null,
    foreign key(perfil) references perfil(codigo),
    primary key(codigo)
);
create table coment_compart(
    postOriginal integer not null,
    postResposta integer not null,
    isComentario boolean check((isComentario = true and isCompart = false) or (isCompart = true and isComentario = false)),
    isCompart boolean check((isComentario = true and isCompart = false) or (isCompart = true and isComentario = false)),
    foreign key(postOriginal) references post(codigo),
    foreign key(postResposta) references post(codigo),
    primary key(postOriginal, postResposta)
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
insert into pais (codigo, nome) values (1,'Brasil');
insert into estado (uf, pais, sigla, nome) values (10, 1, 'RS', 'Rio Grande do Sul');
insert into cidade (municipio, estado, pais, sigla, nome) values (1234567, 10, 1, 'RG', 'Rio Grande');

insert into reacao (nome) values 
    ('Like'),
    ('Haha'),
    ('Amei'),
    ('Wow'),
    ('Grr'),
    ('Triste');

insert into perfil (cidade, estado, pais, nome, dataHora) values 
    (1234567, 10, 1, 'Professor de BD', '2010-01-01 09:00:00'),
    (1234567, 10, 1, 'João Silva Brasil', '2020-01-01 13:00:00'),
    (1234567, 10, 1, 'Pedro Alencar Pereira', '2020-01-01 13:05:00'),
    (1234567, 10, 1, 'Maria Cruz Albuquerque', '2020-01-01 13:10:00'),
    (1234567, 10, 1, 'Joana Rosa Medeiros', '2020-01-01 13:15:00'),
    (1234567, 10, 1, 'Paulo Xavier Ramos', '2020-01-01 13:20:00');

insert into amigo (perfil, perfil_amigo, dataHora) values
    (1, 2, '2021-05-17 10:00:00'),
    (1, 3, '2021-05-17 10:05:00'),
    (1, 4, '2021-05-17 10:10:00'),
    (1, 5, '2021-05-17 10:15:00'),
    (1, 6, '2021-05-17 10:20:00');

insert into perfil (cidade, estado, pais, nome) values (1234567, 10, 1, 'IFRS Campus Rio Grande');
insert into assunto (nome) values ('BD'),('SQLite'),('INSERT'),('Atendimento');

insert into post (perfil, dataHora, texto) values (2, '2021-06-02 15:00:00', 'Hoje eu aprendi como inserir dados no SQLite no IFRS');
insert into assuntoPost (assunto, post) values (1, 1),(2, 1);
insert into perfilCitado (post, perfil_citado) values (1, 7);

insert into reagePost (post, perfil, reacao, dataHora) values (1, 3, 1, '2021-06-02 15:05:00');
insert into reagePost (post, perfil, reacao, dataHora) values (1, 4, 1, '2021-06-02 15:10:00');

insert into post (perfil, dataHora, texto) values (5, '2021-06-02 15:15:00', 'Alguém mais ficou com dúvida no comando INSERT?');
insert into assuntoPost (assunto, post) values (1, 2),(2, 2),(3, 2);
insert into coment_compart (postOriginal, postResposta, isComentario, isCompart) values (1, 2, true, false);

insert into post (perfil, dataHora, texto) values (6, '2021-06-02 15:20:00', 'Eu também');
insert into coment_compart (postOriginal, postResposta, isComentario, isCompart) values (2, 3, true, false);

insert into reagePost (post, perfil, reacao, dataHora) values (2, 6, 6, '2021-06-02 15:20:00');

insert into post (perfil, dataHora, texto) values (2, '2021-06-02 15:30:00', 'Já agendaste horário de atendimento com o professor?');
insert into assuntoPost (assunto, post) values (4, 4),(1, 4);
insert into coment_compart (postOriginal, postResposta, isComentario, isCompart) values (3, 4, true, false);

insert into post (perfil, dataHora, texto) values (1, '2021-06-02 15:35:00', 'Atendimento de BD no GMeet amanhã para quem tiver dúvidas de INSERT');
insert into assuntoPost (assunto, post) values (4, 5),(1, 5),(2, 5),(3, 5);
insert into perfilCitado (post, perfil_citado) values (5, 5),(5, 6);

insert into post (perfil, dataHora, texto) values (2, '2021-06-02 15:40:00', 'Atendimento de BD no GMeet amanhã para quem tiver dúvidas de INSERT');
insert into coment_compart (postOriginal, postResposta, isComentario, isCompart) values (5, 6, false, true);
