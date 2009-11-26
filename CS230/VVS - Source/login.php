<?php
require_once("functions/config.inc.php");
require_once("functions/auth.php");
global $vvs;

if ($vvs['ONLINE']) {
  if($HTTP_COOKIE_VARS["id"] && $HTTP_COOKIE_VARS["name"]) {
    header('Location:http://vvs.ducksarepeople.com/mainScreen.php');
  } else {
    readfile("header.php");
    Login::displayLoginScreen();
  }
} else {
  readfile("header.php");
  Login::displayClosedMessage();
}

readfile("footer.php");
?>
