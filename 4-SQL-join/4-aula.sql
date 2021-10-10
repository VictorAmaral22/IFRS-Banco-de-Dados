SELECT
    [ * | campo | expressão | consulta [ [ AS ] apelido ] [, ... ] ]
    [ FROM tabela | consulta [ [ AS ] apelido ] [ [ LEFT ] JOIN tabela | consulta [ [ AS ] apelido ] ON expressão [ ... ] ] [, ... ] ]
    [ WHERE condição ]
    [ GROUP BY campo | expressão [, ... ] ]
    [ HAVING condição ]
    [ ORDER BY campo | expressão [ ASC | DESC ] [, ... ] ]
    [ LIMIT expressão ]
    [ OFFSET expressão ]
;

sintaxe
    A | B = A ou B
    [ A ] = A é opcional
    A ... = repetição de A

----------------------------------------------------------------------------------------------------

Produto cartesiano
    { 1 2 3 } x { A B } = { 1A 1B 2A 2B 3A 3B }

Junções
    internas (inner join)
        implícita
            from tabela1, tabela2 where tabela1.campo = tabela2.campo
        explícita
            from tabela1 join tabela2 on tabela1.campo = tabela2.campo
    externas (outer join)
        explícita à esquerda
            from tabela1 left join tabela2 on tabela1.campo = tabela2.campo

    SQLJoin.png

* DAR PREFERÊNCIA À JUNÇÃO EXPLÍCITA COM CONDIÇÃO DE JUNÇÃO!

----------------------------------------------------------------------------------------------------

create table montadora (
    codigo integer not null,
    nome varchar(100) not null,
    primary key (codigo)
);

create table modelo (
    codigo integer not null,
    nome varchar(100) not null,
    montadora integer,
    foreign key (montadora) references montadora(codigo),
    primary key (codigo)
);

insert into montadora (codigo, nome) values
(1, 'Ford'),
(2, 'Chevrolet'),
(3, 'Volkswagen'),
(4, 'Fiat'),
(5, 'Gurgel');

insert into modelo (codigo, nome, montadora) values
(11, 'Escort', 1),
(12, 'Corsa', 2),
(13, 'Gol', 3),
(14, 'Uno', 4),
(15, 'Countach', null);

-- produto cartesiano
select *
from montadora, modelo;

      montadora      |             modelo            
--------+------------+--------+----------+-----------
 codigo |    nome    | codigo |   nome   | montadora 
--------+------------+--------+----------+-----------
      1 | Ford       |     11 | Escort   |         1
      1 | Ford       |     12 | Corsa    |         2
      1 | Ford       |     13 | Gol      |         3
      1 | Ford       |     14 | Uno      |         4
      1 | Ford       |     15 | Countach |          
      2 | Chevrolet  |     11 | Escort   |         1
      2 | Chevrolet  |     12 | Corsa    |         2
      2 | Chevrolet  |     13 | Gol      |         3
      2 | Chevrolet  |     14 | Uno      |         4
      2 | Chevrolet  |     15 | Countach |          
      3 | Volkswagen |     11 | Escort   |         1
      3 | Volkswagen |     12 | Corsa    |         2
      3 | Volkswagen |     13 | Gol      |         3
      3 | Volkswagen |     14 | Uno      |         4
      3 | Volkswagen |     15 | Countach |          
      4 | Fiat       |     11 | Escort   |         1
      4 | Fiat       |     12 | Corsa    |         2
      4 | Fiat       |     13 | Gol      |         3
      4 | Fiat       |     14 | Uno      |         4
      4 | Fiat       |     15 | Countach |          
      5 | Gurgel     |     11 | Escort   |         1
      5 | Gurgel     |     12 | Corsa    |         2
      5 | Gurgel     |     13 | Gol      |         3
      5 | Gurgel     |     14 | Uno      |         4
      5 | Gurgel     |     15 | Countach |          
(25 registros)

-- produto cartesiano com junção interna implícita e filtro de junção
-- modelo(montadora) references montadora(codigo)
select *
from montadora, modelo
where modelo.montadora = montadora.codigo;

      montadora      |            modelo           
--------+------------+--------+--------+-----------
 codigo |    nome    | codigo |  nome  | montadora 
--------+------------+--------+--------+-----------
      1 | Ford       |     11 | Escort |         1
      2 | Chevrolet  |     12 | Corsa  |         2
      3 | Volkswagen |     13 | Gol    |         3
      4 | Fiat       |     14 | Uno    |         4
(4 registros)

-- produto cartesiano com junção interna explícita e condição de junção
-- modelo(montadora) references montadora(codigo)
select *
from montadora
    join modelo on modelo.montadora = montadora.codigo;

      montadora      |            modelo           
--------+------------+--------+--------+-----------
 codigo |    nome    | codigo |  nome  | montadora 
--------+------------+--------+--------+-----------
      1 | Ford       |     11 | Escort |         1
      2 | Chevrolet  |     12 | Corsa  |         2
      3 | Volkswagen |     13 | Gol    |         3
      4 | Fiat       |     14 | Uno    |         4
(4 registros)

-- produto cartesiano com junção externa explícita à esquerda e condição de junção
-- modelo(montadora) references montadora(codigo)
select *
from montadora
    left join modelo on modelo.montadora = montadora.codigo;

      montadora      |            modelo           
--------+------------+--------+--------+-----------
 codigo |    nome    | codigo |  nome  | montadora 
--------+------------+--------+--------+-----------
      1 | Ford       |     11 | Escort |         1
      2 | Chevrolet  |     12 | Corsa  |         2
      3 | Volkswagen |     13 | Gol    |         3
      4 | Fiat       |     14 | Uno    |         4
      5 | Gurgel     |        |        |          
(5 registros)

-- produto cartesiano com junção externa explícita à esquerda e condição de junção
-- modelo(montadora) references montadora(codigo)
select *
from modelo
    left join montadora on montadora.codigo = modelo.montadora;

             modelo            |      montadora      
--------+----------+-----------+--------+------------
 codigo |   nome   | montadora | codigo |    nome    
--------+----------+-----------+--------+------------
     11 | Escort   |         1 |      1 | Ford       
     12 | Corsa    |         2 |      2 | Chevrolet  
     13 | Gol      |         3 |      3 | Volkswagen 
     14 | Uno      |         4 |      4 | Fiat       
     15 | Countach |           |        |            
(5 registros)

----------------------------------------------------------------------------------------------------
-- pizzaria.sql
----------------------------------------------------------------------------------------------------

-- sabores por tipo
select tipo.nome as tipo, sabor.nome as sabor
from tipo
    join sabor on sabor.tipo = tipo.codigo
order by 1 asc, 2 asc;

-- sabores das pizzas doces
select sabor.nome as sabor
from tipo
    join sabor on sabor.tipo = tipo.codigo
where tipo.nome like '%doces%'
order by 1 asc;

-- quantidade de sabores de pizzas doces
select count(*) as quantidade
from tipo
    join sabor on sabor.tipo = tipo.codigo
where tipo.nome like '%doces%';

-- quantidade de sabores por tipo
select tipo.nome, count(*) as quantidade
from tipo
    join sabor on sabor.tipo = tipo.codigo
group by tipo.codigo
order by 1 asc;

-- ranking de uso das mesas em setembro de 2020
select mesa.nome as mesa, count(*) as quantidade
from mesa
    join comanda on comanda.mesa = mesa.codigo
where date(comanda.data) between date('2020-09-01') and date('2020-09-30')
group by mesa.codigo
order by 2 desc;

-- ranking de uso das mesas por dia em setembro de 2020
select comanda.data as dia, mesa.nome as mesa, count(*) as quantidade
from mesa
    join comanda on comanda.mesa = mesa.codigo
where date(comanda.data) between date('2020-09-01') and date('2020-09-30')
group by mesa.codigo, comanda.data
order by 1 asc, 3 desc, 2 asc;

-- quantidade máxima de comandas por mesa por dia em setembro de 2020
select count(*) as quantidade
from mesa
    join comanda on comanda.mesa = mesa.codigo
where date(comanda.data) between date('2020-09-01') and date('2020-09-30')
group by mesa.codigo, comanda.data
order by 1 desc
limit 1;

-- mesas que tiveram 3 ou mais comandas em algum dia em setembro de 2020
select distinct mesa.nome as mesa
from mesa
    join comanda on comanda.mesa = mesa.codigo
where date(comanda.data) between date('2020-09-01') and date('2020-09-30')
group by mesa.codigo, comanda.data
having count(*) >= 3
order by 1 asc;

-- ingredientes por sabor
select sabor.nome as sabor, ingrediente.nome as ingrediente
from sabor
    join saboringrediente on saboringrediente.sabor = sabor.codigo
    join ingrediente on saboringrediente.ingrediente = ingrediente.codigo
order by 1 asc, 2 asc;

-- ingredientes do sabor Suécia
select ingrediente.nome as ingrediente
from sabor
    join saboringrediente on saboringrediente.sabor = sabor.codigo
    join ingrediente on saboringrediente.ingrediente = ingrediente.codigo
where lower(sabor.nome) = 'suecia'
order by 1 asc;

-- sabores que contém bacon
select sabor.nome as sabor
from sabor
    join saboringrediente on saboringrediente.sabor = sabor.codigo
    join ingrediente on saboringrediente.ingrediente = ingrediente.codigo
where lower(ingrediente.nome) = 'bacon'
order by 1 asc;

-- pizzas com borda
select *
from pizza
where pizza.borda is not null;

-- pizzas sem borda
select *
from pizza
where pizza.borda is null;

-- pizzas com borda em setembro de 2020
select *
from comanda
    join pizza on pizza.comanda = comanda.numero
    join borda on pizza.borda = borda.codigo
where date(comanda.data) between date('2020-09-01') and date('2020-09-30');

-- pizzas com e sem borda em setembro de 2020
select *
from comanda
    join pizza on pizza.comanda = comanda.numero
    left join borda on pizza.borda = borda.codigo
where date(comanda.data) between date('2020-09-01') and date('2020-09-30');

-- quantidade de pizzas com borda de catupiry em setembro de 2020
select count(*) as quantidade
from comanda
    join pizza on pizza.comanda = comanda.numero
    join borda on pizza.borda = borda.codigo
where date(comanda.data) between date('2020-09-01') and date('2020-09-30') and
    lower(borda.nome) = 'catupiry';

-- ranking das bordas mais pedidas em setembro de 2020
select
    case
        when borda.nome is null then 'SEM BORDA'
        else borda.nome
    end as borda,
    count(*) as quantidade
from comanda
    join pizza on pizza.comanda = comanda.numero
    left join borda on pizza.borda = borda.codigo
where date(comanda.data) between date('2020-09-01') and date('2020-09-30')
group by borda.codigo
order by 2 desc;

-- todos os dados da comanda 12
select comanda.numero as comanda,
    strftime('%d/%m/%Y', comanda.data) as data,
    mesa.nome as mesa,
    comanda.pago,
    pizza.codigo as pizza,
    tamanho.nome as tamanho,
    sabor.nome as sabor,
    tipo.nome as tipo,
    borda.nome as borda,
--    precoportamanho.preco as preco_sabor,
--    borda.preco as preco_borda,
    case
        when borda.preco is null then 0
        else borda.preco
    end+precoportamanho.preco as preco
from comanda
    join mesa on comanda.mesa = mesa.codigo
    join pizza on pizza.comanda = comanda.numero
    join tamanho on pizza.tamanho = tamanho.codigo
    join pizzasabor on pizzasabor.pizza = pizza.codigo
    join sabor on pizzasabor.sabor = sabor.codigo
    join tipo on sabor.tipo = tipo.codigo
    join precoportamanho on precoportamanho.tipo = sabor.tipo and precoportamanho.tamanho = pizza.tamanho
    left join borda on pizza.borda = borda.codigo
where comanda.numero = 12;

-- ingredientes por sabor, 1 linha por sabor
select sabor.nome as sabor,
    group_concat(ingrediente.nome, ', ') as ingredientes
from sabor
    join saboringrediente on saboringrediente.sabor = sabor.codigo
    join ingrediente on saboringrediente.ingrediente = ingrediente.codigo
group by sabor.codigo
order by 1 asc;

