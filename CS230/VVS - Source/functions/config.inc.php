<?php
/*********************
 * DESCRIPTION:
 * Configuration definition for
 * commonly used values in the VVS
 ********************/

$vvs = array();

// SYSTEM STATUS
$vvs['ONLINE'] = true;

// DATABASE INFORMATION
$vvs['DB_NAME'] = "ducksare_vorpallongsword";
$vvs['DB_HOST'] = 'localhost';
$vvs['DB_USER_NAME'] = 'ducksare_vorpal';
$vvs['DB_USER_PASS'] = 'longsword';

//FIELDS IN PEOPLE TABLE
$vvs['PEOPLE_TABLE'] = "people"; //NAME OF TABLE HOLDING ALL USERS
$vvs['PEOPLE_FIELDS'] = array("id", "name", "email", "sex", "age", "grade", "password", "special");

// LENGTH OF AUTHENTICATED SESSION (COOKIES)
$vvs['SESSION_LENGTH'] = time() + (60*20); //20 minutes in the future

// Define other static variables here as the need
// for continuity arises.

?>