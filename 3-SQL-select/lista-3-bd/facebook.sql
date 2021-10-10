-- 1) Escreva comandos select, utilizando as tabelas para uma rede social criadas nas listas de 
-- exercícios anteriores, para responder as perguntas:
-- * Todas as perguntas devem ser respondidas com 1 comando select que acessa apenas 1 tabela. 
-- Se sua modelagem não permite isto, ajuste sua modelagem!

--     a) Quais os assuntos da postagem do usuário João Silva Brasil, em Rio Grande, RS, Brasil às 15:00 de 02/06/2021?
select post, case
    when assunto = 1 then 'BD'
    when assunto = 2 then 'SQLite'
    when assunto = 3 then 'INSERT'
    when assunto = 4 then 'Atendimento'
end as assunto from assuntoPost where post = 1;

--     b) Quantos usuários curtiram a postagem do usuário João Silva Brasil, em Rio Grande, RS, Brasil às 15:00 de 02/06/2021?
select count(*) as qtdCurtidas from reagePost where (
    post = 1 and
    reacao = 1
);

--     c) Quantas postagens o usuário João Silva Brasil realizou nos últimos 30 dias?
select count(*) as qtdPostagens from post where (
    perfil = 2 and
    postComentado IS NULL and 
    postCompart IS NULL and
    date(dataHora) between date('now', '-30 day') and date('now')
);

--     d) Quando foi a última postagem do usuário Maria Cruz Albuquerque?
insert into post (perfil, cidade, estado, pais, dataHora, texto) values (4, 1234567, 10, 1, '2021-06-30 19:30:00', 'Platinei o Witcher 3 hoje, baita jogo!');
insert into post (perfil, cidade, estado, pais, dataHora, texto) values (4, 1234567, 10, 1, '2021-07-01 09:00:00', 'Essas promoções da Steam estão muito boas gente, nossa...');

select * from post where (
    perfil = 4 and 
    postComentado is null and 
    postCompart is null
) order by dataHora desc limit 1;

--     e) Quantos usuários realizaram mais de 50 postagens no Brasil nos últimos 30 dias?
-- Para responder essa questão, seria necessário descobrir quais usuários fizeram mais de 50 postagens nos últimos 30 dias, e depois contá-los. Ou seja, duas queries diferentes, por isso utilizei o subselect.

select count(*) from post where 
    perfil in (
        select count(*) from post where(
            postComentado IS NULL and 
            postCompart IS NULL and
            (date(dataHora) between date('now', '-30 day') and ('now')) and
            pais = 1
        ) group by perfil having count(*) > 50
    );

select count(
    postComentado IS NULL and 
    postCompart IS NULL and
    (date(dataHora) between date('now', '-30 day') and ('now')) and
    pais = 1
)

--     f) Qual o ranking da quantidade de postagens por dia da semana no Brasil nos últimos 7 dias?
insert into post (perfil, cidade, estado, pais, dataHora, texto) values (2, 1234567, 10, 1, '2021-06-30 10:00:00', 'Alguém ai já assistiu Pulp Fiction?');
insert into post (perfil, cidade, estado, pais, dataHora, texto) values (3, 1234567, 10, 1, '2021-06-30 09:30:00', 'Acabei de comprar um box dos livros do Harry Potter!');
insert into post (perfil, cidade, estado, pais, dataHora, texto) values (5, 1234567, 10, 1, '2021-06-28 15:00:00', 'Gente, peguem o Overcooked na Epic. Tá de graça!!');
insert into post (perfil, cidade, estado, pais, dataHora, texto) values (5, 1234567, 10, 1, '2021-06-28 15:05:00', 'Eu sou a vergonh da profision nesse jogo hahaha');
insert into post (perfil, cidade, estado, pais, dataHora, texto) values (4, 1234567, 10, 1, '2021-06-27 15:00:00', 'Comecei a expansão Blood and Wine do the Witcher, to amando s2');

select count(*) as qtdpostagens, case 
		when strftime('%w', dataHora) = '0' then 'Domingo'
		when strftime('%w', dataHora) = '1' then 'Segunda'
		when strftime('%w', dataHora) = '2' then 'Terça'
		when strftime('%w', dataHora) = '3' then 'Quarta'
		when strftime('%w', dataHora) = '4' then 'Quinta'
		when strftime('%w', dataHora) = '5' then 'Sexta'
		when strftime('%w', dataHora) = '6' then 'Sábado'
	end as data from post where 
	(
        postComentado IS NULL and 
        postCompart IS NULL and
		(date(dataHora) between date('now','-7 day') and date('now'))
    ) group by strftime('%w', dataHora) order by qtdPostagens desc;

--     g) Qual o ranking da quantidade de usuários por cidade do RS?
insert into cidade (municipio, estado, pais, nome) values 
    (2345678, 10, 1, 'Pelotas'),
    (3456789, 10, 1, 'Porto Alegre'),
    (4567890, 10, 1, 'Gramado');

insert into perfil (cidade, estado, pais, nome) values 
    (2345678, 10, 1, 'Claudinho'),
    (2345678, 10, 1, 'Kratos'),
    (3456789, 10, 1, 'Joel Santana'),
    (3456789, 10, 1, 'Christina Albuquerque'),
    (3456789, 10, 1, 'Jéssica Jaques'),
    (4567890, 10, 1, 'Pedro Patrício');

select count(*) as qtdUsuarios, case
    when cidade = 1234567 then 'Rio Grande'
    when cidade = 2345678 then 'Pelotas'
    when cidade = 3456789 then 'Porto Alegre'
    when cidade = 4567890 then 'Gramado'
end as cidade from perfil where estado = 10 group by cidade order by qtdUsuarios desc;

--     h) Qual o ranking da quantidade de usuários por estado no Brasil?
insert into estado (uf, pais, sigla, nome) values 
    (11, 1, 'RJ', 'Rio de Janeiro'),
    (12, 1, 'SP', 'São Paulo'),
    (13, 1, 'PE', 'Pernambuco');

insert into cidade (municipio, estado, pais, nome) values 
    (5678901, 11, 1, 'Niterói'),
    (6789012, 12, 1, 'Campinas'),
    (7890123, 13, 1, 'Recife');

insert into perfil (cidade, estado, pais, nome) values 
    (5678901, 11, 1, 'Marislinda Flores'),
    (5678901, 11, 1, 'Baldur'),
    (5678901, 11, 1, 'Loki'),
    (5678901, 11, 1, 'Thor'),
    (6789012, 12, 1, 'Odin'),
    (6789012, 12, 1, 'Posseidon'),
    (7890123, 13, 1, 'Zeus');

select count(*) as qtdUsuarios, case
    when estado = 10 then 'Rio Grande do Sul'
    when estado = 11 then 'Rio de Janeiro'
    when estado = 12 then 'São Paulo'
    when estado = 13 then 'Pernambuco'
end as estado from perfil group by estado order by qtdUsuarios desc;

--     i) Quantos usuários possuem mais de 100 amigos?
-- Visto que é necessário descobrir quais usuários tem mais de cem amigos e depois contar quantos são estes, seriam necessárias duas queries. Por isso utilizei o subselect.
insert into amigo (perfil, perfil_amigo) values 
    (2, 3),
    (3, 2),
    (2, 4),
    (4, 2),
    (3, 5),
    (5, 3),
    (3, 6),
    (6, 3);

select count(*) as qtdPerfis from (
    select perfil, count(*) as qtdAmigos from amigo group by perfil having count(*) > 100
);

--     j) Quantos usuários possuem mais de 100 amigos por estado do Brasil?
-- Assim como o anterior, neste é necessário utilizar dois comandos select, para descobrir quais perfis tem mais de 100 amigos, e depois contar quantos são estes agrupando por estado.

insert into amigo (perfil, perfil_amigo) values 
    (9, 19),
    (19, 9),
    (9, 20),
    (20, 9),
    (20, 19),
    (19, 20);

select count(*) as qtdPerfis, estado from perfil where codigo in (
    select perfil from amigo group by perfil having count(*) > 100
) group by estado;

--     k) Quantos usuários novos se cadastraram nos últimos 12 meses no Brasil?
select count(*) from perfil where (
    (date(dataHora) between date('now', '-12 month') and date('now')) and
    pais = 1
);

--     l) Quantas postagens foram realizadas por dia no Brasil nos últimos 3 meses?
select count(*), date(dataHora) from post where(
    (date(dataHora) between date('now', '-3 month') and date('now')) and
    pais = 1
) group by strftime('%d', dataHora) order by date(dataHora) desc;

--     m) Qual a quantidade média de curtidas nas postagens do usuário Joana Rosa Medeiros nos últimos 3 meses?
-- Visto que nesta questão é preciso saber quantas curtidas ao total tiveram os posts da Joana Rosa Medeiros e dividir pela quantidade de posts dela, temos duas queries em questão. Creio que seja impossível resolver isso com somente um select, e por isso utilizei subselect.

select (
    select count(*) as qtdLikes from reagePost where post in (
        select codigo from post where (
            perfil = 5 and 
            postComentado is null and 
            postCompart is null
            )
    ) and reacao = 1 
)/(
    select count(*) as qtdPosts from post where (
        perfil = 5 and 
        postComentado is null and 
        postCompart is null
    )
);

--     n) Quantos usuários não realizaram postagem nos últimos 12 meses?
-- Para este caso, também foi necessário o subselect em duas tabelas diferentes, isso porque para saber quem não postou, é preciso saber quais são os perfis existentes e comparar com os perfis que postaram.

select count(*) as qtdUsuarios from (
    select codigo from perfil where 
        codigo not in (
            select perfil from post where (
                (date(dataHora) between date('now', '-12 month') and date('now')) and
                postComentado is null and
                postCompart is null
            ) group by perfil
        ) group by codigo
);