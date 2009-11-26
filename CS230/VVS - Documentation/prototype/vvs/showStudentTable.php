<html>
<head
<title>Student Voter List</title>
</head>
<body>


<?php
require_once("functions/config.inc.php");
global $vvs;

$link = mysql_connect($vvs['DB_HOST'], $vvs['DB_USER_NAME'], $vvs['DB_USER_PASS']);
mysql_select_db($vvs['DB_NAME']);

$query = "SELECT * FROM `people`";
$result = mysql_query($query);

echo "<table border='1'>\n";
while($item = mysql_fetch_row($result)) {
  echo "\t<tr>\n";
  foreach ($item as $i) {
    echo "\t\t<td>" . $i . "</td>\n";
  }
  echo "\t</tr>\n";
}
echo "</table>\n";

mysql_close($link);
?>

</body>
</html>