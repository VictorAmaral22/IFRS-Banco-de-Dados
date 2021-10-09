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

RTFM!!!

https://sqlite.org/doclist.html
https://www.sqlitetutorial.net/

----------------------------------------------------------------------------------------------------

Transformação de tipos
* cuidado com conversões implícitas!

select cast('12' as integer);
select cast('12.34' as real);
select cast(false as integer);
select cast(12.34 as integer);
select date('2000-12-31');
select time('12:00:00');
select datetime('2000-12-31 12:00:00');
select date('now','+3 months','-10 days');

Lógicos
Operadores: and or not = <> != < <= > >=

select 2 < 3 as resultado;

Númericos, inteiros e reais
Operadores: + - * / % between
Funções: abs(x) round(x, y) random() 

select 1+(2*3) as resultado;
select 5/2 as resultado;
select 5.0/2.0 as resultado;
select 15 between 10 and 20 as resultado;
select 15 not between 10 and 20 as resultado;

Strings
Operadores: || like
Funções: length(x) lower(x) upper(x) trim(x) instr(x, y) substr(x, y) substr(x, y, z) replace(x, y, z)

select 'abc' || 'def' as resultado; -- concatenação
select 'abc' like 'a%' as resultado; -- começa com a?
select 'abc' like '_b_' as resultado; -- tem um caracter qualquer, b e um caracter qualquer?
select 'abc' like '%c' as resultado; -- acaba com c?
select 'abcdefghi' like '%def%' as resultado; -- contém def?
select 'abcdefghi' like '%bc%fg%' as resultado; -- contém bc e fg?
select 'abcdefghi' not like '%def%' as resultado; -- não contém def?

Datas, horas e datetimes
Constantes: current_date current_time current_timestamp
Operadores: + - between
Funções: date(x, ...) time(x, ...) datetime(x, ...) julianday(x, ...) strftime(x, y, ...)
https://www.sqlite.org/lang_datefunc.html

select date('now', '-1 day') as ontem;
select date('now', '+1 day') as amanha;
select
    strftime('%d', 'now') as dia,
    strftime('%w', 'now') as dia_semana,
    strftime('%j', 'now') as dia_ano;
select date('2005-12-31') between date('2000-12-31') and date('2010-12-31') as resultado;
select date('2005-12-31') not between date('2000-12-31') and date('2010-12-31') as resultado;
select
    strftime('%d/%m/%Y %H:%M:%S', 'now') as greenwich,
    strftime('%d/%m/%Y %H:%M:%S', 'now', 'localtime') as riogrande;
select (julianday('now')-julianday('2000-01-01'))/365.2422; -- idade (aproximada) em anos de uma pessoa que nasceu em  01/01/2000

Conjuntos
Operadores: in

select 'a' in ( 'a', 'e', 'i', 'o', 'u' ) as resultado;
select 'x' not in ( 'a', 'e', 'i', 'o', 'u' ) as resultado;

Condicionais

CASE
    WHEN condição THEN expressão [ ... ]
    [ ELSE expressão ]
END

CASE expressão
    WHEN expressão THEN expressão [ ... ]
    [ ELSE expressão ]
END

sintaxe
    A | B = A ou B
    [ A ] = A é opcional
    A ... = repetição de A

-- data por extenso
select
    case strftime('%w', 'now', 'localtime')
        when '0' then 'domingo'
        when '1' then 'segunda'
        when '2' then 'terca'
        when '3' then 'quarta'
        when '4' then 'quinta'
        when '5' then 'sexta'
        when '6' then 'sabado'
    end || ', ' || strftime('%d', 'now', 'localtime') || ' de ' ||
    case strftime('%m', 'now', 'localtime')
        when '01' then 'janeiro'
        when '02' then 'fevereiro'
        when '03' then 'marco'
        when '04' then 'abril'
        when '05' then 'maio'
        when '06' then 'junho'
        when '07' then 'julho'
        when '08' then 'agosto'
        when '09' then 'setembro'
        when '10' then 'outubro'
        when '11' then 'novembro'
        when '12' then 'dezembro'
    end || ' de ' || strftime('%Y', 'now', 'localtime') as hoje;

Funções de agregação
Funções: count, min, max, sum, avg

----------------------------------------------------------------------------------------------------
-- programacaonet.sql
----------------------------------------------------------------------------------------------------

-- todos os canais
select *
from canal;

-- apenas código e nome de todos os canais
select codigo, nome
from canal;

-- 1a página de 10 canais
select *
from canal
limit 10 offset 0;

-- 2a página de 10 canais
select *
from canal
limit 10 offset 10;

-- 3a página de 10 canais
select *
from canal
limit 10 offset 20;

-- todos os programas do canal CAR
select *
from programa
where canal = 'CAR';

-- 1a página de 10 programas do canal CAR
select *
from programa
where canal = 'CAR'
limit 10 offset 0;

-- 2a página de 10 programas do canal CAR
select *
from programa
where canal = 'CAR'
limit 10 offset 10;

-- 3a página de 10 programas do canal CAR
select *
from programa
where canal = 'CAR'
limit 10 offset 20;

-- 1a página de programas do canal CAR ordenados por nome crescente
select *
from programa
where canal = 'CAR'
order by nome asc
limit 10 offset 0;

-- 1a página de programas do canal CAR ordenados por nome (campo 4) crescente
select *
from programa
where canal = 'CAR'
order by 4 asc
limit 10 offset 0;

-- 1a página de programas do canal CAR ordenados por nome decrescente
select *
from programa
where canal = 'CAR'
order by nome desc
limit 10 offset 0;

-- 1a página de programas do canal CAR ordenados por nome (campo 4) decrescente
select *
from programa
where canal = 'CAR'
order by 4 desc
limit 10 offset 0;

-- 1a página de programas do canal CAR ordenados por nome crescente e horário crescente
select *
from programa
where canal = 'CAR'
order by nome asc, horario asc
limit 10 offset 0;

-- 1a página de programas do canal CAR ordenados por nome decrescente e horário crescente
select *
from programa
where canal = 'CAR'
order by nome desc, horario asc
limit 10 offset 0;

-- nomes dos programas do canal CAR, com repetições
select nome
from programa
where canal = 'CAR'
order by nome asc;

-- nomes dos programas do canal CAR, sem repetições
select distinct nome
from programa
where canal = 'CAR'
order by nome asc;

-- listagem paginada para humanos dos programas do canal CAR
-- valor dos campos canal, horario e nome muda linha a linha
select canal,
    case strftime('%w', horario, 'localtime')
        when '0' then 'domingo'
        when '1' then 'segunda'
        when '2' then 'terca'
        when '3' then 'quarta'
        when '4' then 'quinta'
        when '5' then 'sexta'
        when '6' then 'sabado'
    end as dia_semana,
    strftime('%d/%m/%Y', horario, 'localtime') as data,
    strftime('%H:%M:%S', horario, 'localtime') as hora,
    nome
from programa
where canal = 'CAR'
order by horario asc
limit 10 offset 0;

-- quais programas passaram em 01/05/2009 no canal CAR?

-- considerando horário como datetime
select *
from programa
where canal = 'CAR' and
    datetime(horario) between datetime('2009-05-01 00:00:00') and datetime('2009-05-01 23:59:59');

-- considerando horário como date
select *
from programa
where canal = 'CAR' and
    date(horario) = date('2009-05-01');

-- qual programa está passando em uma certa data e hora no canal CAR?
-- bd = sql + cérebro!

-- em 2009-05-01 13:00
select *
from programa
where canal = 'CAR' and
    datetime(horario) = datetime('2009-05-01 13:00:00');

-- em 2009-05-01 13:10
select *
from programa
where canal = 'CAR' and
    datetime(horario) = datetime('2009-05-01 13:10');
-- a resposta deveria ser Johnny Test que começou em 2009-05-01 13:00:00

-- programas do canal CAR até 2009-05-01 13:10 ordenados por horário decrescente
select *
from programa
where canal = 'CAR' and
    datetime(horario) <= datetime('2009-05-01 13:10')
order by horario desc;
-- o primeiro é Johnny Test que começou em 2009-05-01 13:00:00

-- primeiro dos programas do canal CAR até 2009-05-01 13:10 ordenados por horário decrescente
select *
from programa
where canal = 'CAR' and
    datetime(horario) <= datetime('2009-05-01 13:10')
order by horario desc
limit 1;

----------------------------------------------------------------------------------------------------
-- navenet.sql (não modele nem popule assim!)
----------------------------------------------------------------------------------------------------

-- todas HD de 500GB?
select *
from produto
where descricao like '%hd%500%gb%';

-- todas HD de 500GB
select *
from produto
where descricao like '%hd % 500%gb%';

-- quantas HDs de 500GB?
select count(*) as quantidade
from produto
where descricao like '%hd % 500%gb%';

-- quantas HDs distintas de 500GB?
select count(distinct lower(descricao)) as quantidade
from produto
where descricao like '%hd % 500%gb%';
-- HD NOTEBOOK SATA2 2.5` 500GB HITACHI 5400RPM SLIM está repetida

-- qual preço em R$ da HD de 500GB mais barata?
select min(preco)*5.63 as minimo
from produto
where descricao like '%hd % 500%gb%';

-- qual preço em R$ da HD de 500GB mais cara?
select max(preco)*5.63 as maximo
from produto
where descricao like '%hd % 500%gb%';

-- qual preço médio em R$ das HD de 500GB?
select avg(preco)*5.63 as medio
from produto
where descricao like '%hd % 500%gb%';

-- quais são os departamentos?

-- usando distinct
select distinct departamento
from produto;

-- usando group by
select departamento
from produto
group by departamento;

-- qual a quantidade de produtos por departamento?
select departamento, count(*) as quantidade
from produto
group by departamento;
-- ordena, agrupa e aplica função de agregação em cada grupo

 codigo | descricao | departamento | preco
--------+-----------+--------------+-------
 1      | prod1     | depto1       | 10.00
 2      | prod2     | depto2       | 15.00
 3      | prod3     | depto1       | 20.00
 4      | prod4     | depto2       | 25.00
 5      | prod5     | depto2       | 30.00

 codigo | descricao | departamento | preco
--------+-----------+--------------+-------
 1      | prod1     | depto1       | 10.00        -- grupo 1, departamento = depto1
 3      | prod3     | depto1       | 20.00        -- grupo 1, departamento = depto1
 2      | prod2     | depto2       | 15.00        -- grupo 2, departamento = depto2
 4      | prod4     | depto2       | 25.00        -- grupo 2, departamento = depto2
 5      | prod5     | depto2       | 30.00        -- grupo 2, departamento = depto2

 departamento | quantidade
--------------+------------
 depto1       | 2
 depto2       | 3

-- qual preço médio em R$ de produtos por departamento?
select departamento, avg(preco)*5.63 as medio
from produto
group by departamento;

 codigo | descricao | departamento | preco
--------+-----------+--------------+-------
 1      | prod1     | depto1       | 10.00
 2      | prod2     | depto2       | 15.00
 3      | prod3     | depto1       | 20.00
 4      | prod4     | depto2       | 25.00
 5      | prod5     | depto2       | 30.00

 codigo | descricao | departamento | preco
--------+-----------+--------------+-------
 1      | prod1     | depto1       | 10.00        -- grupo 1, departamento = depto1
 3      | prod3     | depto1       | 20.00        -- grupo 1, departamento = depto1
 2      | prod2     | depto2       | 15.00        -- grupo 2, departamento = depto2
 4      | prod4     | depto2       | 25.00        -- grupo 2, departamento = depto2
 5      | prod5     | depto2       | 30.00        -- grupo 2, departamento = depto2

 departamento | medio
--------------+-------
 depto1       | 15.00*5.63
 depto2       | 23.33*5.63

 departamento | medio
--------------+--------
 depto1       |  84.45
 depto2       | 131.35

-- qual faixa de preços em R$ de produtos por departamento?
select departamento,
    min(preco)*5.63 as menor,
    max(preco)*5.63 as maior
from produto
group by departamento;

-- ranking de departamentos pelo preço médio em R$ de produtos por departamento
select departamento,
    avg(preco)*5.63 as medio
from produto
group by departamento
order by 2 desc;

-- quais departamentos possuem menos de 10 produtos?
select departamento,
    count(*) as quantidade
from produto
group by departamento
having count(*) < 10;
-- where: filtro antes do group by
-- having: filtro depois do group by

-- quais departamentos possuem produto mais barato com preço superior a R$100?
select departamento
from produto
group by departamento
having min(preco)*5.63 > 100;

-- em quais departamentos o produto mais caro do departamento custa até o dobro do preço médio dos produtos daquele departamento?
select departamento
from produto
group by departamento
having max(preco) < 2*avg(preco);

----------------------------------------------------------------------------------------------------
-- programacaonet.sql
----------------------------------------------------------------------------------------------------

-- quantidade de programas do canal CAR por dia?
select date(horario) as data,
    count(*) as quantidade
from programa
where canal = 'CAR'
group by 1
order by 1 asc;

-- quantidade de programas por canal por dia?
select canal,
    date(horario) as data,
    count(*) as quantidade
from programa
group by 1, 2
order by 1 asc, 2 asc;
-- não basta ser por canal
-- não basta ser por dia
-- tem que ser por ambos
-- grupo formado pelas linhas que possuem o mesmo código do canal e a mesma data

-- ranking dos canais que mais passam programas entre 01/05/2009 e 10/05/2009 das 08:00 às 12:00
select canal,
    count(*) as quantidade
from programa
where date(horario) between date('2009-05-01') and date('2009-05-10') and
    time(horario) between time('08:00') and time('12:00')
group by canal
order by 2 desc;

-- quantos programas passam no canal CAR no primeiro domingo de maio de 2009?

-- primeiro domingo de maio de 2009
select date('2009-05-01','weekday 0'); 

-- contando os programas do canal CAR no primeiro domingo de maio de 2009
select count(*) as quantidade
from programa
where canal = 'CAR' and
    date(horario) = date('2009-05-01','weekday 0');

-- ranking da quantidade de programas do Batman, Ben 10, Chaves e Scooby Doo entre 03/05/2009 e 09/05/2009

-- todos os programas do Batman?
select *
from programa
where nome = 'batman';

-- todos os programas do Batman no período
select *
from programa
where date(horario) between date('2009-05-03') and date('2009-05-09') and
    nome like '%batman%';

-- todos os programas do Ben 10 no período
select *
from programa
where date(horario) between date('2009-05-03') and date('2009-05-09') and
    nome like '%ben%10%';

-- todos os programas do Chaves no período
select *
from programa
where date(horario) between date('2009-05-03') and date('2009-05-09') and
    nome like '%chaves%';

-- todos os programas do Scooby Doo no período
select *
from programa
where date(horario) between date('2009-05-03') and date('2009-05-09') and
    nome like '%scooby%doo%';

-- usando case para transformar o nome do programa no nome do personagem
select nome,
    case
        when nome like '%batman%' then 'Batman'
        when nome like '%ben%10%' then 'Ben 10'
        when nome like '%chaves%' then 'Chaves'
        when nome like '%scooby%doo%' then 'Scooby Doo'
    end as personagem
from programa
where (date(horario) between date('2009-05-03') and date('2009-05-09')) and
    (nome like '%batman%' or
    nome like '%ben%10%' or
    nome like '%chaves%' or
    nome like '%scooby%doo%');

-- agrupando e contando pelo nome do personagem
select
    case
        when nome like '%batman%' then 'Batman'
        when nome like '%ben%10%' then 'Ben 10'
        when nome like '%chaves%' then 'Chaves'
        when nome like '%scooby%doo%' then 'Scooby Doo'
    end as personagem,
    count(*) as quantidade
from programa
where (date(horario) between date('2009-05-03') and date('2009-05-09')) and
    (nome like '%batman%' or
    nome like '%ben%10%' or
    nome like '%chaves%' or
    nome like '%scooby%doo%')
group by 1
order by 2 desc;