<?php
$servername = "localhost";
$username = "techvest_picturesqueAdmin";
$password = "Jz08M~.}4*oL";
$dbname = "techvest_picturesque";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

?>