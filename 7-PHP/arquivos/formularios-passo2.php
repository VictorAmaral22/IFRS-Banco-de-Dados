<html>
<body>

<?php
$nascimento = explode("/",$_POST["nascimento"]);
echo (($_POST["genero"] == "m") ? "Sr." : "Sra.")." ".$_POST["nome"].", ".round((mktime(0,0,0,date("m"),date("d"),date("Y"))-mktime(0,0,0,$nascimento[1],$nascimento[0],$nascimento[2]))/60/60/24/365.2422,2)." anos.";
$numero = 1;
echo "<table border=\"1\">";
for ($linha = 0; $linha < $_POST["linhas"]; $linha++) {
	echo "<tr>";
	for ($coluna = 0; $coluna < $_POST["colunas"]; $coluna++) {
		echo "<td>".$numero."</td>";
		$numero++;
	}
	echo "</tr>";
}
echo "</table>";
?>

</body>
</html>

