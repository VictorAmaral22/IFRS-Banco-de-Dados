<html>
<body>
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
<?php
if (isset($_POST["confirma"])) {
	echo "<script>setTimeout(function () { window.open(\"select.php\",\"_self\"); }, 3000);</script>";
}
?>
</html>

