<?php
readfile("header.php");

require_once("functions/config.inc.php");
require_once("functions/getOptions.php");
global $vvs;

$link = mysql_connect($vvs['DB_HOST'], $vvs['DB_USER_NAME'], $vvs['DB_USER_PASS']);
mysql_select_db($vvs['DB_NAME']);

$query0 = "SELECT * from `people` where `id` =" . $HTTP_COOKIE_VARS["id"];
$result0 = mysql_query($query0);
$user = mysql_fetch_assoc($result0);

$query = "SELECT * from `students_voted_" . $_POST["poll_id"] . "` where `student_id` =" . $HTTP_COOKIE_VARS["id"];
$result = mysql_query($query) or die(mysql_error());

if(mysql_num_rows($result) > 0) {
  echo "<p>Nice try, but you've already voted!</p>\n";
  echo "<p>Return to the <a href=\"showOpenPollList.php\">open poll list </a>.</p>\n";
  die();
}

$query1 = "INSERT INTO `poll_" . $_POST["poll_id"]  . "` (`grade`, `sex`, `age`, `" . $_POST["option"] . "`) VALUES (\"" . $user["grade"] . "\", \"" . $user["sex"] . "\", \"" . $user["age"] . "\", \"1\")";
if($result1 = mysql_query($query1)) {
  print("Your vote has been stored.\n");
}
else {
  print("MYSQL ERROR!\n");
  die(mysql_error());
}

$query2 = "INSERT INTO `students_voted_" . $_POST["poll_id"] . "` (`student_id`) VALUES (\"" . $user["id"] . "\")";
if($result2 = mysql_query($query2)) {
  print("Thank you.\n");
}
else {
  print("MYSQL ERROR\n");
  die(mysql_error());
}

readfile("footer.php");
?>