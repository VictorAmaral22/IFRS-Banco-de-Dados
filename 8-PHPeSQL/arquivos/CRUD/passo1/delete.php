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
if (isset($_GET["codigo"])) {
	$db = new SQLite3("pessoa.db");
	$db->exec("PRAGMA foreign_keys = ON");
	$db->exec("delete from pessoa where codigo = ".$_GET["codigo"]);
	echo $db->changes()." pessoa(s) excluída(s)";
	$db->close();
}
?>
</body>
</html>

