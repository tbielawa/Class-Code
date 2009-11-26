<?php
include("functions/sync.php");
global $vvs;

$mySyncer = new SyncVVS("student_db");
$mySyncer->sync();
?>