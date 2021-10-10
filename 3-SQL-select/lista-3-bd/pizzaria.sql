-- 3) Utilizando a modelagem da pizzaria do material, escreva 1 comando select que acessa apenas 1 
-- tabela para responder as perguntas. Caso não seja possível, justifique.

-- a) Quantas pizzas foram pedidas pela comanda 235?
insert into mesa (codigo, nome) values (2, '2A');
insert into comanda (numero, mesa) values (235, 2);
insert into pizza (codigo, comanda, tamanho, borda) values (3, 235, 'G', null),(4, 235, 'F', null),(5, 235, 'P', null);

select count(*) as qtdPizzas from pizza where comanda = 235;

-- b) Quantas pizzas de tamanho grande ou família foram pedidas pela comanda 235?
select count(*) as qtdPizzas from pizza where (comanda = 235 and (tamanho = 'G' or tamanho = 'F'));


-- c) Qual a quantidade de comandas não pagas no última semana?
select count(*) as NaoPagas from comanda where (
    pago = false and 
    (date(data) between date('now', '-7 days') and date('now'))
);

-- d) Quantos ingredientes possui o sabor margherita, sabendo que o código do sabor margherita é 123?
insert into sabor (codigo, nome, tipo) values (123, 'MARGHERITA', 1);
insert into ingrediente (codigo, nome) values (15, 'MAJEIRICÃO'),(16, 'EXTRATO DE TOMATE');
insert into saboringrediente (sabor, ingrediente) values (123, 13), (123, 15), (123, 16);

select count(*) as qtdSabores from saboringrediente where sabor = 123;

-- e) Quantos sabores contém o ingrediente catupiri, sabendo que o código do ingrediente catupiri é 234?
select count(*) as qtdSabores from saboringrediente where ingrediente = 234;

-- f) Qual a quantidade média de ingredientes por sabor?
-- Aqui foi necessário o uso de subselect, visto que é necessário saber quantos ingredientes cada sabor tem, para depois realizar uma média.

select round(avg(qtdIngredientes), 2) as media from (
	select sabor, count(*) as qtdIngredientes from saboringrediente group by sabor
);

-- g) Quantos sabores possuem mais de 8 ingredientes?
-- Neste exercício, como precisamos saber primeiro quais sabores tem mais de 8 ingredientes para depois contá-los, será necessário o uso de subselect.

select count(*) as qtdSabores from sabor where codigo in (
    select sabor from saboringrediente group by sabor having count(*) > 8
);

-- h) Quantos sabores doces possuem mais de 8 ingredientes?
-- Não é possível realizar somente um select em uma tabela para resolver essa questão, pois a tabela saboringrediente não traz o tipo da pizza. Então seria necessário buscar na tabela sabor o tipo. Para descobrir quantos sabores doces tem mais de 8 ingredientes, passamos pela mesma situação da questão anterior, sendo necessário o subselect para realizar essa contagem.

select count(*) as qtdSabores from sabor where 
    codigo in (
        select sabor from saboringrediente group by sabor having count(*) > 8
    ) and
    codigo in (
        select codigo from sabor where tipo = 3
    );

-- i) Qual a quantidade de comandas por dia nos últimos 15 dias?
INSERT INTO comanda VALUES(15,'2021-06-20',1,0);
INSERT INTO comanda VALUES(13,'2021-06-21',1,0);
INSERT INTO comanda VALUES(14,'2021-06-21',1,0);
INSERT INTO comanda VALUES(12,'2021-06-22',1,0);
INSERT INTO comanda VALUES(11,'2021-06-23',1,0);
INSERT INTO comanda VALUES(10,'2021-06-25',1,0);
INSERT INTO comanda VALUES(9,'2021-06-26',2,0);
INSERT INTO comanda VALUES(7,'2021-06-27',2,0);
INSERT INTO comanda VALUES(8,'2021-06-27',2,0);
INSERT INTO comanda VALUES(6,'2021-06-27',2,0);
INSERT INTO comanda VALUES(4,'2021-06-28',2,0);

select date(data) as data, count(*) as qtdComandas from comanda where (date(data) between date('now', '-15 day') and date('now')) group by data order by data desc;

-- j) Quais dias tiveram mais de 10 comandas nos últimos 15 dias?
INSERT INTO comanda VALUES(16,'2021-06-26',2,0);
INSERT INTO comanda VALUES(17,'2021-06-26',2,0);
INSERT INTO comanda VALUES(18,'2021-06-26',2,0);
INSERT INTO comanda VALUES(19,'2021-06-26',2,0);
INSERT INTO comanda VALUES(20,'2021-06-26',2,0);
INSERT INTO comanda VALUES(21,'2021-06-26',2,0);
INSERT INTO comanda VALUES(22,'2021-06-26',2,0);
INSERT INTO comanda VALUES(23,'2021-06-26',2,0);
INSERT INTO comanda VALUES(24,'2021-06-26',2,0);
INSERT INTO comanda VALUES(25,'2021-06-26',2,0);
INSERT INTO comanda VALUES(26,'2021-06-26',2,0);

INSERT INTO comanda VALUES(27,'2021-06-27',2,0);
INSERT INTO comanda VALUES(28,'2021-06-27',2,0);
INSERT INTO comanda VALUES(29,'2021-06-27',2,0);
INSERT INTO comanda VALUES(30,'2021-06-27',2,0);
INSERT INTO comanda VALUES(31,'2021-06-27',2,0);
INSERT INTO comanda VALUES(32,'2021-06-27',2,0);
INSERT INTO comanda VALUES(33,'2021-06-27',2,0);
INSERT INTO comanda VALUES(34,'2021-06-27',2,0);
INSERT INTO comanda VALUES(35,'2021-06-27',2,0);
INSERT INTO comanda VALUES(36,'2021-06-27',2,0);
INSERT INTO comanda VALUES(37,'2021-06-27',2,0);

select date(data) as data, count(*) as qtdComandas from comanda where (date(data) between date('now', '-15 day') and date('now')) group by data having count(*) > 10;

-- k) Qual o ranking da quantidade de comandas por dia da semana em julho de 2020?
INSERT INTO comanda VALUES(44,'2020-07-13',2,0);
INSERT INTO comanda VALUES(45,'2020-07-16',2,0);
INSERT INTO comanda VALUES(46,'2020-07-17',2,0);

select count(*) as qtdComandas, case 
	when strftime('%w', data) = '0' then 'Domingo'
	when strftime('%w', data) = '1' then 'Segunda'
	when strftime('%w', data) = '2' then 'Terça'
	when strftime('%w', data) = '3' then 'Quarta'
	when strftime('%w', data) = '4' then 'Quinta'
	when strftime('%w', data) = '5' then 'Sexta'
	when strftime('%w', data) = '6' then 'Sábado'
	end as data from comanda where 
	(
		(strftime('%m', data) = '07') and
		(strftime('%Y', data) = '2020')
	) group by strftime('%w', data) order by qtdComandas desc;

-- l) Qual o ranking da quantidade de comandas por dia da semana no mês passado?
INSERT INTO comanda VALUES(38,'2021-05-28',2,0);
INSERT INTO comanda VALUES(39,'2021-05-22',2,0);
INSERT INTO comanda VALUES(41,'2021-05-09',2,0);
INSERT INTO comanda VALUES(42,'2021-05-11',2,0);
INSERT INTO comanda VALUES(43,'2021-05-13',2,0);

select count(*) as qtdComandas, case 
		when strftime('%w', data) = '0' then 'Domingo'
		when strftime('%w', data) = '1' then 'Segunda'
		when strftime('%w', data) = '2' then 'Terça'
		when strftime('%w', data) = '3' then 'Quarta'
		when strftime('%w', data) = '4' then 'Quinta'
		when strftime('%w', data) = '5' then 'Sexta'
		when strftime('%w', data) = '6' then 'Sábado'
	end as data from comanda where strftime('%m', data) = strftime('%m', 'now', '-1 month') group by strftime('%w', data) order by count(*) desc;

-- m) Quais dias da semana tiveram menos de 20 comandas no mês passado?
INSERT INTO comanda VALUES(48,'2021-06-01',2,0);

select count(*) as qtdComandas, case 
		when strftime('%w', data) = '0' then 'Domingo'
		when strftime('%w', data) = '1' then 'Segunda'
		when strftime('%w', data) = '2' then 'Terça'
		when strftime('%w', data) = '3' then 'Quarta'
		when strftime('%w', data) = '4' then 'Quinta'
		when strftime('%w', data) = '5' then 'Sexta'
		when strftime('%w', data) = '6' then 'Sábado'
	end as data from comanda where strftime('%m', data) = strftime('%m', 'now', '-1 month') group by strftime('%w', data) having count(*) < 20;

-- n) Qual o ranking dos sabores mais pedidos nos últimos 15 dias?
-- Para encontrar os sabores mais pedidos é necessário acessar várias tabelas diferentes e fazer mais de um select também. Primeiro, precisamos saber quais pizzas foram pedidas nos últimos 15 dias, sendo esse um dos selects, e ele acessa a comanda e confere quais comandas foram pedidas nos últimos 15 dias. Depois compara com as pizzas para saber quais pizzas foram essas e depois compara novamente com os sabores, em pizzasabor. 

insert into comanda values(47,'2021-07-03', 1, 0);
insert into pizza (codigo, comanda, tamanho, borda) values (6, 47, 'M', null),(7, 47, 'G', 1);
insert into pizzasabor values (6, 2), (7, 3), (7, 4);

select case
	when sabor = 1 then '3 QUEIJOS'
	when sabor = 2 then '4 QUEIJOS'
	when sabor = 3 then 'CHARQUE'
	when sabor = 4 then 'BAFO'
	when sabor = 5 then 'MORANGO'
	when sabor = 6 then 'MACA E CANELA'
	when sabor = 123 then 'MARGHERITA'
end as sabor, count(*) as qtdPedidos from pizzasabor where pizza in (
	select codigo from pizza where comanda in (
		select numero from comanda where date(data) between date('now', '-15 day') and date('now')
	)	
) group by sabor order by qtdPedidos desc;


-- o) Qual o valor a pagar da comanda 315?
-- Também não é possivel calcular o valor a pagar por uma comanda sem acessar duas tabelas diferentes e fazer um único select. Isso se dá porque o preço de uma pizza depende do tamanho e da borda, mas o preço de nenhum destes dois está contido na entidade pizza. Poderiamos verificar quais pizzas cada comanda pediu, junto do tamanho e da borda, então seria necessário acessar as entidades correspondentes para calcular o valor.

insert into comanda values(315,'2021-07-04', 2, 0);
insert into pizza (codigo, comanda, tamanho, borda) values (8, 315, 'M', 2),(9, 315, 'G', 1);
insert into pizzasabor values (8, 2), (9, 3), (9, 4);

select (
	select sum(preco) as totalPizzas from (
		select preco from precoportamanho where tipo in (
			select tipo from sabor where codigo in (
				select sabor from pizzasabor where pizza in (
					select codigo from pizza where comanda = 315
				)	
			) group by tipo
		) and tamanho in (
			select tamanho from pizza where comanda = 315
		) group by tipo 
	)	
) + (
	select sum(preco) as totalBordas from (
		select preco from borda where codigo in (
			select borda from pizza where comanda = 315
		)
	)	
);