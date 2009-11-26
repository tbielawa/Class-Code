<?php
include("config.inc.php");

class SyncVVS
{
  function __construct($dataFile) {
    global $vvs;
    $this->vvs = $vvs;
    $this->dataFile = $dataFile;
    echo "Preparing to process new students from " . $this->dataFile;
  }
  
  function sync() {
    // Read in data file
    if( !($data = @file($this->dataFile))) {
      echo "<p>There was a problem reading in the data to be synced.";
      die("<b>Failing...</b>");
    } else {
      echo "<p>Read in " . count($data) . " lines for processing.</p>";
    }
    
    //Connect to DB to store entries
    if ( !($this->link = @mysql_connect($this->vvs['DB_HOST'], $this->vvs['DB_USER_NAME'], 
				  $this->vvs['DB_USER_PASS']))) {
      echo "<p>There was a problem connecting to the VVS database!</p>\n";
      echo "<p>MySQL said: " . mysql_error($this->link) . "</p>\n";
      die("<b>Failing....</b>\n");
    } else {
      mysql_select_db($this->vvs['DB_NAME']);
      echo "<p>Connected to Database.</p>\n";
    }
    
    //For effeciency we'll compile a list of new students, rather
    // pound the database with an excess of queries
    $syncList = array();
    //We'll fill it like a stack, and then implode it

    foreach ($data as &$student) {
      if (strlen($student) <= 1) { //Account for a \n at EOF
	continue;
      }
      $thisStudent = $this->parseLine($student);
      $thisStudent['id'] = $thisStudent['id'] * 1;
      if (count($thisStudent) != 8) { //malformed entry
	echo "<p>(!) Invalid entry in Student Data File.</p>\n";
	echo "<p><b>(!) Skipping: <i>" . print_r($thisStudent) . "</i></b></p>\n";
	continue;
      }
   
      if (!$this->checkDuplicate($thisStudent['id'])) { //They don't exist already
	$values="(\"" . implode("\",\"", $thisStudent) . "\")"; // ("val1","val2","val3",....,"valn")
	array_push($syncList, $values);
      } else { //they exist already.... we should update?
	echo "<p>That student already exists in the database.</p>\n";
	echo "<p>Implement an 'update' function?</p>\n";
	die("<b>Duplicate entry (" . $thisStudent['name'] . ") Bailing!</b>");
      }
    } // End foreach

    $syncString = implode(",", $syncList);
    unset($data); // These have the potential to be huge
    unset($syncList);

    if ($this->addVoters($syncString)) {
      echo "Sync Complete";
      return true;
    } else {
      die("<p>There was an error during insertion. Here's what MySQL said: " . mysql_error() . "</p>\n");
    }
  } // End sync()

  function addVoters(&$voters) {
    $tableFields = "(" . implode(",", $this->vvs['PEOPLE_FIELDS']) . ")";
    $query = "INSERT into `people` " . $tableFields . " VALUES " . $voters;
    if(!($result = @mysql_query($query))) {
      mysql_free_result($result);
      return false;
    } else {
      return true;
    }
  }

  function parseLine($line) {
    $splitLine = explode(",", trim($line, "\n")); //Must remove trailing new line, or password gets destroyed
    array_push($splitLine, "sv"); //By defalt you are a 'student voter'. But that's not in the file we sync
    if (count($splitLine) == count($this->vvs['PEOPLE_FIELDS'])) { //check for malformed entries
      return array_combine($this->vvs['PEOPLE_FIELDS'], $splitLine);
    } else {
      return null;
    }
  }

  function checkDuplicate(&$studentID) {
    $query = "SELECT `id` from `people` where `id` = " . $studentID . " LIMIT 1";
    $result = mysql_query($query);
    return mysql_num_rows($result);
    //return 1 if they already exist
    //return 0 if they don't exist
  }
}
?>