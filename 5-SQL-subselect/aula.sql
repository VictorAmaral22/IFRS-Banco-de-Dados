Subconsultas
    Quanto à localização
        na lista de campos (com apelido)
        no from (com apelido)
        no where/having (sem apelido)
    Quanto à vinculação
        sem vinculação
        com vinculação (para-cada-faça)

Operações com conjuntos
    Pertinência
        expressão IN (consulta)
        expressão NOT IN (consulta)
    União
        consulta UNION [ ALL ] consulta
    Intersecção
        consulta INTERSECT consulta
    Diferença
        consulta EXCEPT consulta

sintaxe
    A | B = A ou B
    [ A ] = A é opcional
    A ... = repetição de A

----------------------------------------------------------------------------------------------------
-- navenet.sql
----------------------------------------------------------------------------------------------------

-- qual preço em R$ da HD de 500GB mais barata e mais cara?
select
    (select min(preco)
    from produto
    where descricao like '%hd % 500%gb%')*5.63 as minimo,
    (select max(preco)
    from produto
    where descricao like '%hd % 500%gb%')*5.63 as maximo;

-- quais HD de 500GB custam menos de R$200?
select *
from
    (select *
    from produto
    where descricao like '%hd % 500%gb%') as tmp
where tmp.preco*5.63 < 200;

-- qual a HD de 500GB mais barata?
select *
from produto
where descricao like '%hd % 500%gb%' and
    preco =
        (select min(preco)
        from produto
        where descricao like '%hd % 500%gb%');

-- quais HD de 500GB possuem preço abaixo da média?
select *
from produto
where descricao like '%hd % 500%gb%' and
    preco <
        (select avg(preco)
        from produto
        where descricao like '%hd % 500%gb%');

-- qual o departamento com mais produtos?

select departamento, count(*)
from produto
group by departamento
having count(*) =
    (select count(*)
    from produto
    group by departamento
    order by 1 desc
    limit 1);

-- forma 2
select departamento, count(*)
from produto
group by departamento
having count(*) = 
    (select max(tmp.quantidade)
    from
        (select count(*) as quantidade
        from produto
        group by departamento) as tmp);

-- forma 3
select tmp2.departamento
from
    (select departamento, count(*) as quantidade
    from produto
    group by departamento) as tmp2
where tmp2.quantidade =
    (select max(tmp1.quantidade)
    from
        (select count(*) as quantidade
        from produto
        group by departamento) as tmp1);

----------------------------------------------------------------------------------------------------
-- pizzaria.sql
----------------------------------------------------------------------------------------------------

-- quantidade de ingredientes de cada sabor

-- sem subconsulta
select sabor.nome as sabor, count(*) as quantidade
from sabor
    join saboringrediente on saboringrediente.sabor = sabor.codigo
group by 1
order by 2 desc;

-- com subconsulta, sem vinculação
select sabor.nome as sabor, tmp.quantidade
from sabor
    join
        (select sabor, count(*) as quantidade
        from saboringrediente
        group by sabor) as tmp on sabor.codigo = tmp.sabor
order by 2 desc;

-- com subconsulta, com vinculação
select sabor.nome as sabor,
    (select count(*)
    from saboringrediente
    where saboringrediente.sabor = sabor.codigo) as quantidade
from sabor
order by 2 desc;

-- mesas utilizadas em 09/08/2020

-- com join
select distinct mesa.nome as mesa
from comanda
    join mesa on comanda.mesa = mesa.codigo
where date(comanda.data) = date('2020-08-09')
order by 1 asc;

-- com in
select mesa.nome as mesa
from mesa
where mesa.codigo in
    (select comanda.mesa
    from comanda
    where date(comanda.data) = date('2020-08-09'))
order by 1 asc;

-- mesas não utilizadas em 09/08/2020

-- com join
select mesa.nome as mesa
from mesa
    left join
        (select *
        from comanda
        where date(comanda.data) = date('2020-08-09')) as tmp on mesa.codigo = tmp.mesa
where tmp.mesa is null;

-- com in
select mesa.nome as mesa
from mesa
where mesa.codigo not in
    (select comanda.mesa
    from comanda
    where date(comanda.data) = date('2020-08-09'))
order by 1 asc;

-- mesas utilizadas em 09/08/2020 ou em 16/08/2020

-- com join
select distinct mesa.nome as mesa
from comanda
    join mesa on comanda.mesa = mesa.codigo
where date(comanda.data) = date('2020-08-09') or
    date(comanda.data) = date('2020-08-16')
order by 1 asc;

-- com in
select mesa.nome as mesa
from mesa
where mesa.codigo in
        (select comanda.mesa
        from comanda
        where date(comanda.data) = date('2020-08-09')) or
    mesa.codigo in
        (select comanda.mesa
        from comanda
        where date(comanda.data) = date('2020-08-16'))
order by 1 asc;

-- com union
select mesa.nome as mesa
from comanda
    join mesa on comanda.mesa = mesa.codigo
where date(comanda.data) = date('2020-08-09')
union
select mesa.nome as mesa
from comanda
    join mesa on comanda.mesa = mesa.codigo
where date(comanda.data) = date('2020-08-16')
order by 1 asc;

-- mesas utilizadas em 09/08/2020 e também em 16/08/2020

-- com join
select distinct mesa.nome as mesa
from
    (select comanda.mesa
    from comanda
    where date(comanda.data) = date('2020-08-09')) as tmp1
    join
        (select comanda.mesa
        from comanda
        where date(comanda.data) = date('2020-08-16')) as tmp2 on tmp1.mesa = tmp2.mesa
    join mesa on mesa.codigo = tmp1.mesa
order by 1 asc;

-- com in
select mesa.nome as mesa
from mesa
where mesa.codigo in
    (select comanda.mesa
    from comanda
    where date(comanda.data) = date('2020-08-09') and
        comanda.mesa in
            (select comanda.mesa
            from comanda
            where date(comanda.data) = date('2020-08-16')))
order by 1 asc;

-- com intersect
select mesa.nome as mesa
from comanda
    join mesa on comanda.mesa = mesa.codigo
where date(comanda.data) = date('2020-08-09')
intersect
select mesa.nome as mesa
from comanda
    join mesa on comanda.mesa = mesa.codigo
where date(comanda.data) = date('2020-08-16')
order by 1 asc;

-- mesas utilizadas em 16/08/2020 mas não em 09/08/2020

-- com in
select mesa.nome as mesa
from mesa
where mesa.codigo in
    (select comanda.mesa
    from comanda
    where date(comanda.data) = date('2020-08-16') and
        comanda.mesa not in
            (select comanda.mesa
            from comanda
            where date(comanda.data) = date('2020-08-09')))
order by 1 asc;

-- com except
select mesa.nome as mesa
from comanda
    join mesa on comanda.mesa = mesa.codigo
where date(comanda.data) = date('2020-08-16')
except
select mesa.nome as mesa
from comanda
    join mesa on comanda.mesa = mesa.codigo
where date(comanda.data) = date('2020-08-09')
order by 1 asc;

-- sabores salgados que não contém palmito

-- com in
select sabor.nome
from sabor
    join tipo on sabor.tipo = tipo.codigo
where tipo.nome like '%salgada%' and
    sabor.codigo not in
        (select sabor.codigo
        from sabor
            join tipo on sabor.tipo = tipo.codigo
            join saboringrediente on saboringrediente.sabor = sabor.codigo
            join ingrediente on saboringrediente.ingrediente = ingrediente.codigo
        where tipo.nome like '%salgada%' and
            lower(ingrediente.nome) = 'palmito')
order by 1 asc;

-- com except
select sabor.nome
from sabor
    join tipo on sabor.tipo = tipo.codigo
where tipo.nome like '%salgada%'
except
select sabor.nome
from sabor
    join tipo on sabor.tipo = tipo.codigo
    join saboringrediente on saboringrediente.sabor = sabor.codigo
    join ingrediente on saboringrediente.ingrediente = ingrediente.codigo
where tipo.nome like '%salgada%' and
    lower(ingrediente.nome) = 'palmito'
order by 1 asc;

-- dias da semana com as 3 maiores quantidades de pizza

-- ranking da quantidade de pizzas por dia da semana
select strftime('%w', comanda.data) as diasemana, count(*) as quantidade
from comanda
    join pizza on pizza.comanda = comanda.numero
group by strftime('%w', comanda.data)
order by 2 desc;

-- 3 maiores quantidades de pizzas por dia da semana
select distinct count(*) as quantidade
from comanda
    join pizza on pizza.comanda = comanda.numero
group by strftime('%w', comanda.data)
order by 1 desc
limit 3;

-- dias da semana com as 3 maiores quantidades de pizza
select
    case strftime('%w', comanda.data)
        when '0' then 'Dom'
        when '1' then 'Seg'
        when '2' then 'Ter'
        when '3' then 'Qua'
        when '4' then 'Qui'
        when '5' then 'Sex'
        when '6' then 'Sab'
    end as diasemana,
    count(*) as quantidade
from comanda
    join pizza on pizza.comanda = comanda.numero
group by strftime('%w', comanda.data)
having count(*) in
    (select distinct count(*) as quantidade
    from comanda
        join pizza on pizza.comanda = comanda.numero
    group by strftime('%w', comanda.data)
    order by 1 desc
    limit 3)
order by 2 desc;

-- valor total da comanda 12

-- valor de cada sabor e borda da comanda 12
select comanda.numero, comanda.data, comanda.mesa, pizza.codigo, pizza.tamanho, sabor.nome, precoportamanho.preco, borda.preco,
    case
        when borda.preco is null then 0
        else borda.preco
    end+precoportamanho.preco as preco
from comanda
    join pizza on pizza.comanda = comanda.numero
    join pizzasabor on pizzasabor.pizza = pizza.codigo
    join sabor on pizzasabor.sabor = sabor.codigo
    join precoportamanho on precoportamanho.tipo = sabor.tipo and precoportamanho.tamanho = pizza.tamanho
    left join borda on pizza.borda = borda.codigo
where comanda.numero = 12;

-- valor de cada pizza da comanda 12
select
    max(case
            when borda.preco is null then 0
            else borda.preco
        end+precoportamanho.preco) as preco
from comanda
    join pizza on pizza.comanda = comanda.numero
    join pizzasabor on pizzasabor.pizza = pizza.codigo
    join sabor on pizzasabor.sabor = sabor.codigo
    join precoportamanho on precoportamanho.tipo = sabor.tipo and precoportamanho.tamanho = pizza.tamanho
    left join borda on pizza.borda = borda.codigo
where comanda.numero = 12
group by pizza.codigo;

-- valor total da comanda 12
select sum(tmp.preco) as total
from
    (select
        max(case
                when borda.preco is null then 0
                else borda.preco
            end+precoportamanho.preco) as preco
    from comanda
        join pizza on pizza.comanda = comanda.numero
        join pizzasabor on pizzasabor.pizza = pizza.codigo
        join sabor on pizzasabor.sabor = sabor.codigo
        join precoportamanho on precoportamanho.tipo = sabor.tipo and precoportamanho.tamanho = pizza.tamanho
        left join borda on pizza.borda = borda.codigo
    where comanda.numero = 12
    group by pizza.codigo) as tmp;

-- valor total das comandas de 09/08/2020
select tmp.numero as comanda, sum(tmp.preco) as total
from
    (select comanda.numero, pizza.codigo,
        max(case
                when borda.preco is null then 0
                else borda.preco
            end+precoportamanho.preco) as preco
    from comanda
        join pizza on pizza.comanda = comanda.numero
        join pizzasabor on pizzasabor.pizza = pizza.codigo
        join sabor on pizzasabor.sabor = sabor.codigo
        join precoportamanho on precoportamanho.tipo = sabor.tipo and precoportamanho.tamanho = pizza.tamanho
        left join borda on pizza.borda = borda.codigo
    where date(comanda.data) = date('2020-08-09')
    group by comanda.numero, pizza.codigo) as tmp
group by tmp.numero;

-- comanda de maior valor total em 09/08/2020
select tmp.numero as comanda, sum(tmp.preco) as total
from
    (select comanda.numero, pizza.codigo,
        max(case
                when borda.preco is null then 0
                else borda.preco
            end+precoportamanho.preco) as preco
    from comanda
        join pizza on pizza.comanda = comanda.numero
        join pizzasabor on pizzasabor.pizza = pizza.codigo
        join sabor on pizzasabor.sabor = sabor.codigo
        join precoportamanho on precoportamanho.tipo = sabor.tipo and precoportamanho.tamanho = pizza.tamanho
        left join borda on pizza.borda = borda.codigo
    where date(comanda.data) = date('2020-08-09')
    group by comanda.numero, pizza.codigo) as tmp
group by tmp.numero
having sum(tmp.preco) =
    (select sum(tmp.preco)
    from
        (select comanda.numero, pizza.codigo,
            max(case
                    when borda.preco is null then 0
                    else borda.preco
                end+precoportamanho.preco) as preco
        from comanda
            join pizza on pizza.comanda = comanda.numero
            join pizzasabor on pizzasabor.pizza = pizza.codigo
            join sabor on pizzasabor.sabor = sabor.codigo
            join precoportamanho on precoportamanho.tipo = sabor.tipo and precoportamanho.tamanho = pizza.tamanho
            left join borda on pizza.borda = borda.codigo
        where date(comanda.data) = date('2020-08-09')
        group by comanda.numero, pizza.codigo) as tmp
    group by tmp.numero
    order by 1 desc
    limit 1);