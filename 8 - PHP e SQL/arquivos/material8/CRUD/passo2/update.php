<html>
<body>
<?php
if (isset($_GET["codigo"])) {
	$db = new SQLite3("pessoa.db");
	$db->exec("PRAGMA foreign_keys = ON");
	$results = $db->query("select * from pessoa where codigo = ".$_GET["codigo"]);
	$row = $results->fetchArray();
	$db->close();
	if ($row === false) {
		echo "<font color=\"red\">Pessoa não encontrada</font>";
	} else {
		echo "<form name=\"update\" action=\"update.php\" method=\"post\">\n";
		echo "<input type=\"hidden\" name=\"codigo\" value=\"".$row["codigo"]."\">";
		echo "<table>\n";
		echo "<tr>\n";
		echo "<td>Nome</td>\n";
		echo "<td><input type=\"text\" name=\"nome\" value=\"".$row["nome"]."\" size=\"50\"></td>\n";
		echo "</tr>\n";
		echo "<tr>\n";
		echo "<td>Gênero</td>\n";
		echo "<td><input type=\"radio\" name=\"genero\" value=\"m\" ".(($row["genero"] == "m") ? "checked" : "").">Masculino <input type=\"radio\" name=\"genero\" value=\"f\" ".(($row["genero"] == "f") ? "checked" : "").">Feminino</td>\n";
		echo "</tr>\n";
		echo "<tr>\n";
		echo "<td>Nascimento</td>\n";
		echo "<td><input type=\"text\" name=\"nascimento\" value=\"".$row["nascimento"]."\" size=\"10\"></td>\n";
		echo "</tr>\n";
		echo "</table>\n";
		echo "<input type=\"submit\" name=\"confirma\" value=\"Confirma\">\n";
		echo "</form>\n";
	}
} else {
	if (isset($_POST["confirma"])) {
		$error = "";
		//coloque aqui o código para validação dos campos recebidos
		//se ocorreu algum erro, preencha a variável $error com uma mensagem de erro
		if ($error == "") {
			$db = new SQLite3("pessoa.db");
			$db->exec("PRAGMA foreign_keys = ON");
			$db->exec("update pessoa set nome = '".$_POST["nome"]."', genero = '".$_POST["genero"]."', nascimento = '".$_POST["nascimento"]."' where codigo = ".$_POST["codigo"]);
			echo $db->changes()." pessoa(s) alterada(s)";
			$db->close();
		} else {
			echo "<font color=\"red\">".$error."</font>";
		}
	}
}
?>
</body>
<?php
if (isset($_POST["confirma"])) {
	echo "<script>setTimeout(function () { window.open(\"select.php\",\"_self\"); }, 3000);</script>";
}
?>
</html>
