<?php 
readfile("header.php");

require_once("functions/config.inc.php");
require_once("functions/getOptions.php");
global $vvs;

$link = mysql_connect($vvs['DB_HOST'], $vvs['DB_USER_NAME'], $vvs['DB_USER_PASS']);
mysql_select_db($vvs['DB_NAME']);

$query0 = "SELECT * from `students_voted_" . $_SERVER["QUERY_STRING"] ."` where `student_id` =" . $HTTP_COOKIE_VARS["id"]; 
$result0 = mysql_query($query0) or die(mysql_error());

$query1 = "SHOW columns from `poll_" . $_SERVER["QUERY_STRING"];
$result1 = mysql_query($query1);
$options = pollOptions($result1);

$query2 = "SELECT name from `polls` where `id` =" . $_SERVER["QUERY_STRING"];
$result2 = mysql_query($query2);
$name = mysql_result($result2,0,0);


if(mysql_num_rows($result0) > 0) {
  echo "<p>You have already voted in " . $name . "!</p>\n";
  echo "<p>Return to the <a href=\"showOpenPollList.php\">open poll list </a>.</p>\n";
  die();
}

echo "<h2>" . $name . "</h2>\n";
#echo "<form name=\"" . $name  . "\" action=\"submitVote.php\" method=\"POST\"> \n";
echo "<form name=\"" . $name  . "\" action=\"confirmation.php\" method=\"POST\"> \n";

foreach ($options as $option) {
  echo "\t<input type=\"radio\" name=\"option\" value=\"" . $option  . "\">" . $option  . "<br>\n";
}
echo "\t<input type=\"hidden\" name=\"poll_id\" value=\"" . $_SERVER["QUERY_STRING"] . "\">\n";
echo "\t<br>\n\t<input type=\"submit\" value=\"Submit\">\n";
echo "</form>\n";

readfile("footer.php");
?>


