<?php
/***********************************
 * Description: Handles actions called by individual scripts
 * in the main VVS volder.
 * For Example: login.php calls the "login" method in this 
 * file
 ***********************************/

/*************************
 *
 * HANDLING URL QUERY STRINGS (process.php?someAction)
 *
 * That is in the $_SERVER["QUERY_STRING"] variable
 * When in doubt..... phpinfo() is your friend :D :D :D
 ************************/
require_once("functions/config.inc.php");

//phpinfo();

// ADD NEW CASES BELOW AND INCLUDE FUNCTIONS AS REQUIRED
switch($_SERVER["QUERY_STRING"]) {
 case "newPoll":
   readfile("header.php");
   require_once("functions/pollFunctions.php");
   echo "You are creating a new poll. AWESOME!!!<BR>\n";
   echo "Press '<i>Step 2</i>' when you're ready to add your options<BR><BR>";
   Poll::displayBasicOptions();
   break;

 case "definePollOptions":
   readfile("header.php");
   require_once("functions/pollFunctions.php");
   $pollFunctions = new Poll();
   if(!$pollFunctions->validateBasicPollOptions($_POST)) {
     echo "There was an error with the values input for creating a new poll.<BR>\n";
     echo "<a href='http://vvs.ducksarepeople.com/process.php?newPoll'>Go Back</a> and try again.\n";
     exit;
   }

   $pollFunctions->displayOptionsDefinition($_POST);
   break;

 case "processNewPoll":
   readfile("header.php");
   require_once("functions/pollFunctions.php");
   $pollFunctions = new Poll();
   if(!$pollFunctions->validateEachPollOption($_POST["pollValues"])) {
     echo "Invalid values for some poll options. No duplicates are allowed. No empty strings are allowed";
     break;
   }
   if(!$pollFunctions->addNewPoll($_POST)) {
     echo "Error while creating poll.";
   } else {
     echo "Poll created successfully!";
   }

   break;

 case "login":
   require_once("functions/auth.php");
   //EXPECTS: $_POST["email"], $_POST["password"]

   $loginFunctions = new Login();

   if(!$loginFunctions->requiredFields($_POST)) {
     readfile("header.php");
     echo "You forgot to enter a required field. Go back to <a href='login.php'>login</a>.";
     readfile("footer.php");
     die("Bailing...");
   }

   $userInformation = $loginFunctions->checkAuthentication($_POST["email"], $_POST["password"]);
   if(!$userInformation) {
     readfile("header.php");
     echo "Invalid credentials supplied.<BR>";
     echo "You suck at life. <a href='login.php'>Try again</a>?";
     readfile("footer.php");
     die("Bailing....");
   }

   // Enough credentials supplied, name found in database, correct password supplied.
   // you win!
   
   if(!$loginFunctions->setCookies()) {
     readfile("header.php");
     echo "Cookies could not be set. We have to die now....";
     readfile("footer.php");
     die("Bailing...");
   }
   header('Location:http://vvs.ducksarepeople.com/mainScreen.php');
   echo "<h2>Authentication Successful</h2><br><br>\n\n";
   echo "Continue to the <a href='mainScreen.php'>main menu</a><br>\n";
   echo "Or go straight <a href='showOpenPollList.php'>the open poll list</a>\n";
   break;

 default:
   require_once("functions/auth.php");
   if(Login::validateCookies()) {
     header('Location:http://vvs.ducksarepeople.com/mainScreen.php');
   } else {
     header('Location:http://vvs.ducksarepeople.com/login.php');
   }
   break;
}

  







readfile("footer.php");
?>