<?php
/*********************
 * DESCRIPTION: Provides methods used during
 * the authentication process and methods used for
 * determining correct authorizations.
 ********************/
include("functions/config.inc.php");

class Login
{
  function __construct() {
    global $vvs;
    $this->vvs = $vvs;
  }
  
  function validateCookies() {
    if(!$HTTP_COOKIE_VARS["id"] || !$HTTP_COOKIE_VARS["name"]) {
      return false;
    } else {
      return true;
    }
  }

  function displayLoginScreen() {
    echo "<center><h2>MU Ballot Login</h2></center>\n";
    echo "<form action='process.php?login' method='post'>\n";
    echo "MU Email Address:<br>\n";
    echo "<input type='text' name='email'><br>\n";
    echo "Password:<br>\n";
    echo "<input type='password' name='password'><br>\n";
    echo "<input type='submit' value='Login'>\n";
    echo "<input type='reset' value='Clear'>\n";
    echo "</form>";
  }

  function displayClosedMessage() {
    echo "<center><h1>Closed. Go away. Now</h1></center>";
  }
  
  function requiredFields($passedFields) {
    $requiredFields = array("email", "password");
    foreach($requiredFields as $rf) {
      if ($passedFields[$rf] == null) {
	return false;
      }
    }
    return true;
  }

  function checkAuthentication($name, $password) {
    if( !($this->link = mysql_connect($this->vvs['DB_HOST'], $this->vvs['DB_USER_NAME'],
				      $this->vvs['DB_USER_PASS']))) {
      echo "<p>There was a problem connecting to the VVS database!</p>\n";
      echo "<p>MySQL said: " . mysql_error($this->link) . "</p>\n";
      die("<b>Failing....</b>\n");
    } else {
      mysql_select_db($this->vvs['DB_NAME']);
    }

    $query = "SELECT * from `" . $this->vvs['PEOPLE_TABLE'] . "` WHERE `email` = '" . $name . "' LIMIT 1";
    $result = mysql_query($query, $this->link);

    if(mysql_num_rows($result) == 0) { //not found in database
      return false;
    } 
    $this->userInformation = mysql_fetch_assoc($result);
    //print_r($this->userInformation);
    if($password != $this->userInformation["password"]) {
      return false;
    }
    return true;
  }

  function setCookies() {
    if(!setcookie("name", $this->userInformation["name"], $this->vvs['SESSION_LENGTH'])) {
      return false;
    } elseif(!setcookie("id", $this->userInformation["id"], $this->vvs['SESSION_LENGTH'])) {
      return false;
    } else {
      return true;
    }
  }
}
?>