UPDATE tabela [ [ AS ] apelido ]
	SET campo = expressão | consulta [, ... ]
	[ FROM tabela | consulta [ [ AS ] apelido ] [, ... ] ]
	[ WHERE condição ]
	[ RETURNING * | campo | expressão [ [ AS ] apelido ] [, ... ] ]
;

sintaxe
	A | B = A ou B
	[ A ] = A é opcional
	A ... = repetição de A

----------------------------------------------------------------------------------------------------

-- com 1 tabela
update tabela1
set campo2 = valor2+campo2
where campo1 = valor1;

-- com 2 tabelas, condição de junção no where
update tabela1
set tabela1.campo2 = valor2+tabela1.campo2+tabela2.campo2
from tabela2
where tabela1.campo3 = tabela2.campo3 and tabela1.campo1 = valor1;

----------------------------------------------------------------------------------------------------
-- navenet.sql
----------------------------------------------------------------------------------------------------

-- dar 10% de desconto nas HD de 500GB
update produto
set preco = preco*0.9
where descricao like '%hd % 500%gb%';

----------------------------------------------------------------------------------------------------

DELETE FROM tabela [ [ AS ] apelido ]
    [ WHERE condição ]
	[ RETURNING * | campo | expressão [ [ AS ] apelido ] [, ...] ]
;

sintaxe
	A | B = A ou B
	[ A ] = A é opcional
	A ... = repetição de A

* CUIDAR INTEGRIDADE REFERENCIAL!

----------------------------------------------------------------------------------------------------

-- hard delete
delete
from tabela1
where campo1 = valor1;

-- soft delete
update tabela1
set ativo = false
where campo1 = valor1;

----------------------------------------------------------------------------------------------------
-- navenet.sql
----------------------------------------------------------------------------------------------------

-- excluir todos os produtos sem departamento
delete
from produto
where departamento = '';

----------------------------------------------------------------------------------------------------

Controle de concorrência

-- por timestamp da última alteração
select * from produto where codigo = 10; -- alterado = '2020-10-01 12:05:25', armazena o valor do campo última alteração
update produto set quantidade = quantidade-1, alterado = current_timestamp where codigo = 10 and alterado = datetime('2020-10-01 12:05:25'); 
-- utiliza o valor armazenado da última alteração
