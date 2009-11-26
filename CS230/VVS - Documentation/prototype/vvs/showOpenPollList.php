<?php
readfile("header.php");

require_once("functions/config.inc.php");
global $vvs;

echo "Logged in as: <tt>" . $HTTP_COOKIE_VARS["name"] . "</tt><BR>\n";

$link = mysql_connect($vvs['DB_HOST'], $vvs['DB_USER_NAME'], $vvs['DB_USER_PASS']);
mysql_select_db($vvs['DB_NAME']);


$query = "SELECT * from `polls` where `opendate` < NOW() AND `closedate` > NOW()";
$result = mysql_query($query);

echo "<table border='0'>\n";
while($item = mysql_fetch_assoc($result)) {
  echo "\t<tr>\n";
  echo "\t\t<td><a href=\"displayPoll.php?" . $item["id"] . "\">" . $item["name"] . "</a></td>\n";
  echo "\t</tr>\n";
}
echo "<table>\n";

mysql_close($link);

readfile("footer.php");
?>
