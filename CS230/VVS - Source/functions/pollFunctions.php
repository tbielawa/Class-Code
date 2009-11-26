<?php
/*************************
 * DESCRIPTION: Handles the poll creation, 
 * and etc functions
 ************************/
require_once("config.inc.php");


class Poll {
  function __construct() {
    global $vvs;
    $this->vvs = $vvs;
  }

  function displayBasicOptions() {
    echo "<form action='process.php?definePollOptions' method='post'>\n";
    echo "<b>Poll Name: </b> <input type='text' name='pollName'><BR>\n";
    echo "<hr width='200'>";
    //START DATE
    echo "<b>Poll Start Date (YYYY-MM-DD): </b><BR>\n";
    //Year
    echo "<select name='startYear'>\n";
    for($year=date("Y"); $year < date("Y") + 5; $year++) {
      echo "\t<option value='" . $year . "'>" . $year . "\n";
    }
    echo "</select> - \n";
    //Month
    echo "<select name='startMonth'>\n";
    for($i=1; $i < 13; $i++) {
      echo "\t<option value='$i'>$i\n";
    }
    echo "</select> - \n";
    //Day
    echo "<select name='startDay'>\n";
    for($i=1; $i < 32; $i++) {
      echo "\t<option value='$i'>$i\n";
    }
    echo "</select><BR>\n";
    echo "<hr width='200'>";

    // END DATE
    echo "<b>Poll End date (YYYY-MM-DD): </b><BR>\n";
    //Year
    echo "<select name='endYear'>\n";
    for($year=date("Y"); $year < date("Y") + 5; $year++) {
      echo "\t<option value='" . $year . "'>" . $year . "\n";
    }
    echo "</select> - \n";
    //Month
    echo "<select name='endMonth'>\n";
    for($i=1; $i < 13; $i++) {
      echo "\t<option value='$i'>$i\n";
    }
    echo "</select> - \n";
    //Day
    echo "<select name='endDay'>\n";
    for($i=1; $i < 32; $i++) {
      echo "\t<option value='$i'>$i\n";
    }
    echo "</select><BR>\n";
    echo "<hr width='200'>";

    //OPTIONS
    echo "<b>Number of Poll Optons: <input type='text' name='pollOptions' size='5'><BR>\n";
    echo "<hr width='200'>";

    //SUBMIT
    echo "<input type='submit' value='Step 2'><input type='reset'>\n";
    echo "</form>\n";
   }

  function displayOptionsDefinition($fields) {
    echo "<form action='process.php?processNewPoll' method='post'>\n";
    foreach($fields as $key => $value) {
      echo "<input type='hidden' name='$key' value='$value'>\n";
    }
    echo "Now define the options for poll \"" . $fields["pollName"] . "\"<BR><BR>\n";
    for($i = 1; $i <= $fields["pollOptions"]; $i++) {
      echo "Poll Option #$i: <input type='text' name='pollValues[$i]' maxlength='35'><BR>\n";
    }
    echo "<input type='submit' value='Create New Poll!'><input type='reset'>\n";
    echo "</form>\n";
  }

  function validateEachPollOption($pollOptions) {
    //check for duplicates
    //array_keys(array,search) will return an array with size >1 if 'search' finds
    // that a value is in 'array' more than once
    foreach($pollOptions as $op) {
      if(count(array_keys($pollOptions, $op)) > 1) {
	return false;
      } elseif (strlen($op) == 0) {
	return false;
      }
    }
    return true;
  }

  //FINALLY!!!!!!!!!!!!!1
  function addNewPoll($fields) {
    $this->link = mysql_connect($this->vvs['DB_HOST'], $this->vvs['DB_USER_NAME'], $this->vvs['DB_USER_PASS']);
    mysql_select_db($this->vvs['DB_NAME']);

    //QUERY TO ADD NEW POLL TO POLLS TABLE
    $startDate = $fields["startYear"] . "-" . $fields["startMonth"] . "-" . $fields["startDay"] . " 00:00:00";
    $endDate = $fields["endYear"] . "-" . $fields["endMonth"] . "-" . $fields["endDay"] . " 00:00:00";
    $pollName = $fields["pollName"];
    $newPoll = "INSERT INTO `polls` (`name`, `opendate`, `closedate`) VALUES('$pollName', '$startDate', '$endDate')";
    $newPollResult = mysql_query($newPoll) or die(mysql_error());
    
    //QUERY TO GET NEW POLL ID
    $newPollIDQuery = "SELECT MAX(`id`) from `polls`";
    $newPollIDResult = mysql_query($newPollIDQuery) or die(mysql_error());
    $newPollID = mysql_result($newPollIDResult, 0, 0);

    //QUERY TO MAKE NEW students_voted_{id} TABLE
    $newStudentsVotedTable = "CREATE TABLE `students_voted_$newPollID` ";
    $newStudentsVotedTable .= "(student_id int(10) unsigned not null,";
    $newStudentsVotedTable .= "primary key(student_id))";
    $newStudentResult = mysql_query($newStudentsVotedTable) or die(mysql_error());

    //QUERY TO MAKE NEW poll_{id} TABLE
    $newPollTable = "CREATE TABLE `poll_$newPollID` ";
    $newPollTable .= "(id int(10) not null auto_increment, ";
    $newPollTable .= "grade enum('9', '10', '11', '12') not null, ";
    $newPollTable .= "sex enum('m', 'f') not null, ";
    $newPollTable .= "age int(2) unsigned not null ,";
    foreach($fields["pollValues"] as $pv) {
      $newPollTable .= "`$pv` int(2) unsigned not null default '0', ";
    }
    $newPollTable .= "primary key(id))";

    $newPollTableResult = mysql_query($newPollTable) or die(mysql_error());
    return true;
  }

  function validateBasicPollOptions($fields) {
    $link = mysql_connect($this->vvs['DB_HOST'], $this->vvs['DB_USER_NAME'], $this->vvs['DB_USER_PASS']);
    mysql_select_db($this->vvs['DB_NAME']);

    $requiredFields = array("pollName", "startYear", "startMonth", "startDay", "endYear", "endMonth", "endDay", "pollOptions");
    foreach($requiredFields as $rf) {
      if(!$fields[$rf]) {
	return false;
      }
    }
    
    if(!is_numeric($fields["pollOptions"])) {
      echo "Please use an integer when specifying the number of poll options<BR>\n";
      echo $fields["pollOptions"] . " is not a valid integer.";
      return false;
    }

    $startDate = $fields["startYear"] . "-" . $fields["startMonth"] . "-" . $fields["startDay"] . " 00:00:00";
    $endDate = $fields["endYear"] . "-" . $fields["endMonth"] . "-" . $fields["endDay"] . " 00:00:00";
    $dateCheck = "SELECT datediff('$startDate', '$endDate')";
    $result = mysql_query($dateCheck);
    $dateDiff = mysql_result($result, 0, 0);

    if($dateDiff >= 0) {
      echo "The end date must occur after the start date.<BR>\n";
      return false;
    }
    return true;
  }
}
?>