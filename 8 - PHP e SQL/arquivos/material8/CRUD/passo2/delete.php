<html>
<body>
<?php
if (isset($_GET["codigo"])) {
	$db = new SQLite3("pessoa.db");
	$db->exec("PRAGMA foreign_keys = ON");
	$db->exec("delete from pessoa where codigo = ".$_GET["codigo"]);
	echo $db->changes()." pessoa(s) excluída(s)";
	$db->close();
}
?>
</body>
<script>
setTimeout(function () { window.open("select.php","_self"); }, 3000);
</script>
</html>

