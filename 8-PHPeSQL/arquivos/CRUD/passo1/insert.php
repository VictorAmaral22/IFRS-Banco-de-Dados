<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Document</title>
	<link rel="stylesheet" href="style.css">
</head>
<body>
    <header id="header">
        <ul>
            <li class="headers"><a href="./index.html">Home</a></li>
            <li class="headers"><a href="./select.php">Select</a></li>
            <li class="headers"><a href="./insert.php">Insert</a></li>
            <li class="headers"><a href="./delete.php">Delete</a></li>
            <li class="headers"><a href="./update.php">Update</a></li>
        </ul>
    </header>

<?php
if (isset($_POST["confirma"])) {
	$error = "";
	//coloque aqui o código para validação dos campos recebidos
	//se ocorreu algum erro, preencha a variável $error com uma mensagem de erro
	if ($error == "") {
		$db = new SQLite3("pessoa.db");
		$db->exec("PRAGMA foreign_keys = ON");
		$db->exec("insert into pessoa (nome, genero, nascimento) values ('".$_POST["nome"]."', '".$_POST["genero"]."', '".$_POST["nascimento"]."')");
		echo $db->changes()." pessoa(s) incluída(s)<br>\n";
		echo $db->lastInsertRowID()." é o código da última pessoa incluída.\n";
		$db->close();
	} else {
		echo "<font color=\"red\">".$error."</font>";
	}
} else {
	echo "<form name=\"insert\" action=\"insert.php\" method=\"post\">\n";
	echo "<table>\n";
	echo "<tr>\n";
	echo "<td>Nome</td>\n";
	echo "<td><input type=\"text\" name=\"nome\" value=\"\" size=\"50\"></td>\n";
	echo "</tr>\n";
	echo "<tr>\n";
	echo "<td>Gênero</td>\n";
	echo "<td><input type=\"radio\" name=\"genero\" value=\"m\" checked>Masculino <input type=\"radio\" name=\"genero\" value=\"f\">Feminino</td>\n";
	echo "</tr>\n";
	echo "<tr>\n";
	echo "<td>Nascimento</td>\n";
	echo "<td><input type=\"text\" name=\"nascimento\" value=\"\" size=\"10\"></td>\n";
	echo "</tr>\n";
	echo "</table>\n";
	echo "<input type=\"submit\" name=\"confirma\" value=\"Confirma\">\n";
	echo "</form>\n";
}
?>
</body>
</html>

