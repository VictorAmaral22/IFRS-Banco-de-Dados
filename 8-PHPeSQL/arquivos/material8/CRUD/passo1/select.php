<html>
<body>
<table border="1">
<tr>
<td>Código</td>
<td>Nome</td>
<td>Gênero</td>
<td>Nascimento</td>
</tr>
<?php
// C:\INFO\IFRS-BD\8-PHPeSQL\arquivos\material8\CRUD\passo1

$where = array();
if (isset($_GET["codigo"])) {
	$where[] = "codigo = ".$_GET["codigo"];
}
if (isset($_GET["nome"])) {
	$where[] = "nome like '%".strtr($_GET["nome"], " ", "%")."%'";
}
if (isset($_GET["genero"])) {
	$where[] = "genero = '".$_GET["genero"]."'";
}
if (isset($_GET["nascimento"])) {
	$where[] = "date(nascimento) = date('".$_GET["nascimento"]."')";
}
$where = (count($where) > 0) ? "where ".implode(" and ", $where) : "";
$orderby = (isset($_GET["orderby"])) ? "order by ".$_GET["orderby"] : "";
$limit = (isset($_GET["limit"])) ? "limit ".$_GET["limit"] : "";
$offset = (isset($_GET["offset"])) ? "offset ".$_GET["offset"] : "";
$db = new SQLite3("pessoa.db");
$db->exec("PRAGMA foreign_keys = ON");
$results = $db->query(trim("select * from pessoa ".$where." ".$orderby." ".$limit." ".$offset));
while ($row = $results->fetchArray()) {
	echo "<tr><td>".$row["codigo"]."</td><td>".$row["nome"]."</td><td>".$row["genero"]."</td><td>".$row["nascimento"]."</td></tr>\n";
}
$db->close();
?>
</table>
<br>
php -S localhost:8080 -c php.ini<br>
<br>
http://localhost:8080/select.php<br>
http://localhost:8080/select.php?limit=5<br>
http://localhost:8080/select.php?limit=5&offset=3<br>
http://localhost:8080/select.php?orderby=nome+asc<br>
http://localhost:8080/select.php?orderby=nascimento+desc<br>
http://localhost:8080/select.php?orderby=genero+asc,nascimento+desc<br>
http://localhost:8080/select.php?orderby=genero+asc,nascimento+desc&limit=5&offset=0<br>
http://localhost:8080/select.php?codigo=2<br>
http://localhost:8080/select.php?nome=lopes<br>
http://localhost:8080/select.php?nome=cris+lopes<br>
http://localhost:8080/select.php?genero=f<br>
http://localhost:8080/select.php?nascimento=1978-03-25<br>
http://localhost:8080/select.php?nome=lopes&genero=m&orderby=nascimento+desc&limit=1&offset=1<br>
<br>
http://localhost:8080/insert.php<br>
<br>
http://localhost:8080/update.php?codigo=1<br>
<br>
http://localhost:8080/delete.php?codigo=1<br>
</body>
</html>

