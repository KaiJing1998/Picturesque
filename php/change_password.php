<?php
error_reporting(0);
include_once("dbconnect.php");

$email = $_POST['email'];
$username = $_POST['username'];
$password = $_POST['password'];


$usersql = "SELECT * FROM USER WHERE EMAIL = '$email'";

if (isset($username) && (!empty($username))){
    $sql = "UPDATE USER SET USERNAME = '$username' WHERE EMAIL = '$email'";
}
if (isset($password) && (!empty($password))){
    $sql = "UPDATE USER SET PASSWORD = sha1($password) WHERE EMAIL = '$email'";
}


if ($conn->query($sql) === TRUE) {
    $result = $conn->query($usersql);
if ($result->num_rows > 0) {
        while ($row = $result ->fetch_assoc()){
        echo "success,".$row["USERNAME"].",".$row["EMAIL"];
        }
    }else{
        echo "failed,null,null";
    }
} else {
    echo "error";
}

$conn->close();
?>