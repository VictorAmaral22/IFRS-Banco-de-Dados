<?php

//sqlite3 teste.db < sqlite3.sql
//php -c php.ini sqlite3.php

echo "SQLite3 nativo\n";
$connection = new SQLite3('teste.db');
$results = $connection->query('SELECT * FROM teste');
while ($row = $results->fetchArray()) {
	var_dump($row);
}
$connection->close();

echo "SQLite3 PDO\n";
$connection = new PDO('sqlite:teste.db');
$results = $connection->query('SELECT * FROM teste');
while ($row = $results->fetch()) {
	var_dump($row);
}
$connection = null;

?>

