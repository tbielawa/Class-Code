<?php
require_once("functions/config.inc.php");
global $vvs;
readfile("header.php");

echo "<b>Confirmation</b><BR>\n";
echo "Are you certain you want to submit your vote for: '" . $_POST["option"] . "'<BR>\n";
echo "<form action='submitVote.php' method='post'>\n";
foreach($_POST as $key => $value) {
  echo "<input type='hidden' name='$key' value='$value'>\n";
}
echo "Press back on your browser to change your vote or press \n";
echo "<input type='submit' value='confirm'> to confirm.";
echo "</form>";


readfile("footer.php");
?>
