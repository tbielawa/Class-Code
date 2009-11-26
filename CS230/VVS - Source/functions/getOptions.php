<?php
function pollOptions($result) {
  $columns = mysql_num_rows($result);
  $fieldOptions = array();
  for($i = 4; $i < $columns; $i++) {
    $fieldOptions[$i] = mysql_result($result, $i, 0);
  }
  return $fieldOptions;
}

/********
 * use as:
 * require_once(getOptions.php);
 * $options = pollOptions($result);
*********/
?>