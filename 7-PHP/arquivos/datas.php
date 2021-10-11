<html>
<body>
<?php
echo "<h1>Utilizando mktime</h1>";

$hoje = mktime(date("H"),date("i"),date("s"),date("m"),date("d"),date("Y"));
$ontem = mktime(date("H"),date("i"),date("s"),date("m"),date("d")-1,date("Y"));
$amanha = mktime(date("H"),date("i"),date("s"),date("m"),date("d")+1,date("Y"));
$ultimomes = mktime(date("H"),date("i"),date("s"),date("m")-1,date("d"),date("Y"));
$proximoano = mktime(date("H"),date("i"),date("s"),date("m"),date("d"),date("Y")+1);
$_2000_09_10 = mktime(0,0,0,9,10,2000);

echo "hoje = ".$hoje." = ".date("d/m/Y H:i:s",$hoje)."<br>";
echo "ontem = ".$ontem." = ".date("d/m/Y H:i:s",$ontem)."<br>";
echo "amanha = ".$amanha." = ".date("d/m/Y H:i:s",$amanha)."<br>";
echo "ultimo mes = ".$ultimomes." = ".date("d/m/Y H:i:s",$ultimomes)."<br>";
echo "proximo ano = ".$proximoano." = ".date("d/m/Y H:i:s",$proximoano)."<br>";
echo "10 de setembro de 2000 = ".$_2000_09_10." = ".date("d/m/Y H:i:s",$_2000_09_10)."<br>";
echo "diferenca em dias entre proximo ano e hoje = ".(($proximoano-$hoje)/60/60/24)."<br>";

echo "<h1>Utilizando strtotime</h1>";

$hoje = strtotime("now");
$ontem = strtotime("-1 day");
$amanha = strtotime("+1 day");
$ultimomes = strtotime("last month");
$proximoano = strtotime("next year");
$_2000_09_10 = strtotime("2000-09-10"); // "10 September 2000"
$proximaquinta = strtotime("next Thursday");
$ultimasegunda = strtotime("last Monday");
$futuro = strtotime("+1 week 2 days 4 hours 2 seconds",$_2000_09_10);

echo "hoje = ".$hoje." = ".date("d/m/Y H:i:s",$hoje)."<br>";
echo "ontem = ".$ontem." = ".date("d/m/Y H:i:s",$ontem)."<br>";
echo "amanha = ".$amanha." = ".date("d/m/Y H:i:s",$amanha)."<br>";
echo "ultimo mes = ".$ultimomes." = ".date("d/m/Y H:i:s",$ultimomes)."<br>";
echo "proximo ano = ".$proximoano." = ".date("d/m/Y H:i:s",$proximoano)."<br>";
echo "10 de setembro de 2000 = ".$_2000_09_10." = ".date("d/m/Y H:i:s",$_2000_09_10)."<br>";
echo "diferenca em dias entre proximo ano e hoje = ".(($proximoano-$hoje)/60/60/24)."<br><br>";
echo "proxima quinta = ".$proximaquinta." = ".date("d/m/Y H:i:s",$proximaquinta)."<br>";
echo "ultima segunda = ".$ultimasegunda." = ".date("d/m/Y H:i:s",$ultimasegunda)."<br>";
echo "uma semana, dois dias, quatro horas e dois segundos a partir de 10 de setembro de 2000 = ".$futuro." = ".date("d/m/Y H:i:s",$futuro)."<br>";
?>
</body>
</html>

