<html>
<body>
<?php

echo "<b>POST</b>";
echo "<pre>";
var_dump($_POST);
echo "</pre>";
echo "<hr>";

$invalidos = 0;
if (!isset($_POST["inteiro"])) {
	$invalidos++;
} else {
	if (!preg_match("#^(0|[1-9][0-9]*)$#", $_POST["inteiro"])) {
		$invalidos++;
	}
}
if (!isset($_POST["real"])) {
	$invalidos++;
} else {
	if (!preg_match("#^(0|[1-9][0-9]*)\.[0-9]+$#", $_POST["real"])) {
		$invalidos++;
	}
}
if (!isset($_POST["literal"])) {
	$invalidos++;
} else {
	if (!preg_match("#^[a-z]+( [a-z]+)*$#", $_POST["literal"])) {
		$invalidos++;
	}
}
if (!isset($_POST["nome"])) {
	$invalidos++;
} else {
	if (!preg_match("#^[A-Z][a-z]+( [A-Z][a-z]+)+$#", $_POST["nome"])) {
		$invalidos++;
	}
}
if (!isset($_POST["data"])) {
	$invalidos++;
} else {
	if (!preg_match("#^(0?[1-9]|[12][0-9]|3[01])/(0?[1-9]|1[0-2])/(19|2[0-9])[0-9]{2}$#", $_POST["data"])) {
		$invalidos++;
	}
}
if (!isset($_POST["hora"])) {
	$invalidos++;
} else {
	if (!preg_match("#^([01]?[0-9]|2[0-3])(:[0-5]?[0-9]){1,2}$#", $_POST["hora"])) {
		$invalidos++;
	}
}
if (!isset($_POST["cpf"])) {
	$invalidos++;
} else {
	if (!preg_match("#^[0-9]{9}-[0-9]{2}$#", $_POST["cpf"])) {
		$invalidos++;
	}
}
if (!isset($_POST["email"])) {
	$invalidos++;
} else {
	if (!preg_match("#^[a-z0-9]+([_\.][a-z0-9]+)*@[a-z0-9]+([_\.][a-z0-9]+)*\.[a-z]{3}(\.[a-z]{2})?$#", $_POST["email"])) {
		$invalidos++;
	}
}
if (!isset($_POST["telefone"])) {
	$invalidos++;
} else {
	if (!preg_match("#^[0-9]{2} [0-9]{4,5}-[0-9]{4}$#", $_POST["telefone"])) {
		$invalidos++;
	}
}
if (!isset($_POST["cep"])) {
	$invalidos++;
} else {
	if (!preg_match("#^[0-9]{5}-[0-9]{3}$#", $_POST["cep"])) {
		$invalidos++;
	}
}
if (!isset($_POST["placa"])) {
	$invalidos++;
} else {
	if (!preg_match("#^[A-Z]{3} [0-9][A-Z][0-9]{2}$#", $_POST["placa"])) {
		$invalidos++;
	}
}
if (!isset($_POST["uf"])) {
	$invalidos++;
} else {
	if (!preg_match("#^[A-Z]{2}$#", $_POST["uf"])) {
		$invalidos++;
	}
}
if (!isset($_POST["cidade"])) {
	$invalidos++;
} else {
	if ($_POST["cidade"] == "outra") {
		if (!isset($_POST["outra"])) {
			$invalidos++;
		} else {
			if (!preg_match("#^[A-Z][a-z]+( [A-Z][a-z]+)*$#", $_POST["outra"])) {
				$invalidos++;
			}
		}
	} else {
		if (!preg_match("#^[A-Z][a-z]+( [A-Z][a-z]+)*$#", $_POST["cidade"])) {
			$invalidos++;
		}
	}
}
for ($telefone = 1; $telefone <= 5; $telefone++) {
	if ((isset($_POST["telefone1_".$telefone])) && (!preg_match("#^[0-9]{2} [0-9]{4,5}-[0-9]{4}$#", $_POST["telefone1_".$telefone]))) {
		$invalidos++;
	}
}
for ($telefone = 1; $telefone <= 5; $telefone++) {
	if ((isset($_POST["telefone2_".$telefone])) && (!preg_match("#^[0-9]{2} [0-9]{4,5}-[0-9]{4}$#", $_POST["telefone2_".$telefone]))) {
		$invalidos++;
	}
}

if ($invalidos == 0) {
	echo "sem erros";
	// código PHP realizando alguma tarefa com os dados recebidos
} else {
	echo "com erros";
}

?>
</body>
</html>

