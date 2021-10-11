<?php

// PHP com SQLite3
// 	https://www.php.net/manual/en/class.sqlite3.php
	
	new SQLite3(string $filename): SQLite3
	exec(string $statement): boolean
	changes(): int
	lastInsertRowID(): int
	query(string $statement): SQLite3Result|boolean
	fetchArray(): array|boolean
	close(): boolean

// Executado select
	$db = new SQLite3("banco.db");
	$db->exec("PRAGMA foreign_keys = ON");
	$results = $db->query("select ... from ... where ...");
	while ($row = $results->fetchArray()) {
		var_dump($row);
	}
	$db->close();

// Executado insert
	$db = new SQLite3("banco.db");
	$db->exec("PRAGMA foreign_keys = ON");
	$db->exec("insert into ... (...) values (...)");
	echo $db->changes()." ...(s) incluída(s)";
	echo $db->lastInsertRowID()." é o código da última ... incluída.";
	$db->close();

// Executando update
	$db = new SQLite3("banco.db");
	$db->exec("PRAGMA foreign_keys = ON");
	$db->exec("update ... set ... where ...");
	echo $db->changes()." ...(s) alterada(s)";
	$db->close();

// Executando delete
	$db = new SQLite3("banco.db");
	$db->exec("PRAGMA foreign_keys = ON");
	$db->exec("delete from ... where ...");
	echo $db->changes()." ...(s) excluída(s)";
	$db->close();

// Exemplos
	// CRUD/passo1/: select.php, insert.php, update.php, delete.php
	// CRUD/passo2/: select.php, insert.php, update.php, delete.php

// Geração de relatórios no PHP com mPDF
	// https://mpdf.github.io/

	new \Mpdf\Mpdf(): Mpdf
	SetHTMLHeader(string $html): void
	SetHTMLFooter(string $html): void
	WriteHTML(string $html): void
	Output(string $filename, string $mode = "D"): void

// Exemplos
	// PDF/relatorio-arrecadacao.php