<?php

// HTML
// 	https://www.w3schools.com/html/html_intro.asp
// 	https://www.w3schools.com/tags/default.asp

// Tabelas
// 	https://www.w3schools.com/html/html_tables.asp

// Formulários
// 	https://www.w3schools.com/html/html_forms.asp

// Eventos
// 	https://www.w3schools.com/tags/ref_eventattributes.asp

// Expressões regulares
// 	https://www.w3schools.com/jsref/jsref_obj_regexp.asp
// 	https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Regular_Expressions
// 	https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Regular_Expressions/Cheatsheet

// Exemplos
// 	formularios.html

// ====================================================================================================

// PHP
// 	https://www.php.net/
// 	https://www.w3schools.com/php/php_intro.asp

// Tags
	<?php
	?>

// Comentários
	//, /**/

// Tipos de dados
	boolean, int, float, string, array, object

// Criação de variáveis
	$boolean = true;
	$integer = 12;
	$float = 123.45;
	$string = "abc";
	$array = array(1, 2, 3);

// Transformação de tipos
	$integer = (int)true;
	$integer = (int)123.45;
	$integer = (int)"123";
	$float = (float)"123.45";
	$integer = "123abc"+0;
	$float = "123.45abc"+0;
	$string = "".(123);

// Operadores
	Matemáticos: + - * / % ++ -- += -= *= /= %=
	Lógicos: ! && ||
	Relacionais: == === != !== < <= > >=
	String: . .=

// Strings
	$string = "abcdef";
	echo $string[0];
	echo $string[strlen($string)-1];
	echo $string[-2];
	$string[0] = "z";

// Arrays
	$array = array("a", "b", "c");
	$array = array(0 => "a", 1 => "b", 2 => "c");
	$array = array(1 => "a", "1" => "b", 1.5 => "c", true => "d");
	$array = array(12, "abc", 123.45, true, array(1, 2, 3));
	$array = array("1" => 12, -1 => "abc", 1.5 => true, "abc" => false, 2.7 => array(1, 2, 3));
	echo $array[-1];
	echo $array["abc"];
	echo $array[2.7][0];
	$array = array();
	$array[100] = 1;
	$array[1000] = 2;
	$array[] = 3;
	echo count($array);

// Variáveis variáveis
	$var1 = "var2";
	$$var1 = 123;
	echo $var2;

// Condições
	if (condição) {
		comandos
	} else {
		comandos
	}

	(condição) ? valor1 : valor2

	switch (expressão) {
		case valor1: {
			comandos
			break;
		}
		case valor1: {
			comandos
			break;
		}
		default: {
			comandos
		}
	}

// Repetições
	while (condição) {
		comandos
	}

	do {
		comandos
	} while (condição);

	for (inicialização; condição; atualização) {
		comandos
	}

	foreach (lista as item) {
		comandos
	}

	foreach (lista as chave => item) {
		comandos
	}

// Funções matemáticas
	// https://www.php.net/manual/en/ref.math.php
	// https://www.w3schools.com/php/php_ref_math.asp

	abs(mixed $number): mixed
	ceil(mixed $number): float
	floor(mixed $number): float
	max(mixed ...): mixed
	min(mixed ...): mixed
	pow(mixed $base, mixed $exp): mixed
	rand(): int
	rand(int $min, int $max): int
	round(float $number): float
	round(float $number, int $precision): float
	sqrt(float $number): float

// Funções de strings
// 	https://www.php.net/manual/en/ref.strings.php
// 	https://www.w3schools.com/php/php_ref_string.asp

	chr(int $ascii): string
	explode(string $separator, string $string): array
	implode(string $separator, array $array): string
	ord(string $character): int
	strlen(string $string): int
	strpos(string $haystack, string $needle): mixed
	strpos(string $haystack, string $needle, int $offset): mixed
	strtolower(string $string): string
	strtoupper(string $string): string
	strtr(string $string, string $from, string $to): string
	strtr(string $string, array $array): string
	substr(string $string, int $offset): string
	substr(string $string, int $offset, int $length): string
	trim (string $string): string

// Funções de datas e horas
// 	https://www.php.net/manual/en/ref.datetime.php
// 	https://www.w3schools.com/php/php_ref_date.asp

	checkdate(int $month, int $day, int $year): boolean
	date(string $format): string
	date(string $format, int $timestamp): string
	getdate(): array
	getdate(int $timestamp): array
	mktime(int $hour, int $minute, int $second, int $month, int $day, int $year): int
	strtotime(string $datetime): int
	strtotime(string $datetime, int $timestamp): int

// Funções de arrays
// 	https://www.php.net/manual/en/ref.array.php
// 	https://www.w3schools.com/php/php_ref_array.asp

	array(mixed ...): array
	arsort(array $array, int $sort_flags): void
	asort(array $array, int $sort_flags): void
	array_splice(array $array, int $offset): array
	array_splice(array $array, int $offset, int $length): array
	array_splice(array $array, int $offset, int $length, array $replacement): array
	count(array $array): int
	in_array (mixed $value, array $array): boolean
	array_search(mixed $value, array $array, bool $strict = false): int|string|false

// Funções variadas
// 	https://www.php.net/manual/en/ref.var.php
// 	https://www.php.net/manual/en/function.printf.php
// 	https://www.w3schools.com/php/php_ref_variable_handling.asp
// 	https://www.w3schools.com/php/func_string_printf.asp

	gettype (mixed $value): string
	is_numeric(mixed $value): boolean
	isset(mixed $variable): boolean
	print_r(mixed $value): void
	var_dump(mixed $value): void
	printf(string $format, mixed ...): int

// Funções criadas pelo programador

	function função(parâmetro1, parâmetro2, ...) {
		comandos
	}

	// Retorno de uma função
		return(expressão);

	// Valores padrão para parâmetros de uma função
		function função(parâmetro1 = default1, parâmetro2 = default2, ...)

		function imprime($par1, $par2 = 2, $par3 = 3) {
			echo $par1." ".$par2." ".$par3;
		}
		imprime(10);
		imprime(10, 20);
		imprime(10, 20, 30);

	// Funções variáveis
		$funcao = "imprime";
		$funcao(2, 4, 6);

// Referências

	// Referências para variáveis
		$var1 = 1;
		$var2 = &$var1;
		$var2 = 2;
		echo $var1;

	// Referências para variáveis em parêmetros
		function func1($par1, &$par2) {
			$par1 = 1;
			$par2 = 2;
		}
		$var1 = "a";
		$var2 = "b";
		func1($var1, $var2);
		echo $var1." ".$var2;

// Exceções e erros

	// Tratando exceções e erros
		try {
			comandos
		} catch (exceção) {
			comandos
		} catch (erro) {
			comandos
		} finally {
			comandos
		}

	// Disparando uma exceção
		throw new Exception(mensagem);

	// Disparando um erro
		throw new Error(mensagem);

// Organização do código
	include, include_once
	require, require_once

// Variáveis especiais
	$_GET, $_POST, $_SERVER

// Exemplos
	// datas.php
	// formularios-passo1.html, formularios-passo2.php
	// formularios-validacao-passo1.html, formularios-validacao-passo2.php