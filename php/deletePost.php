<?php
error_reporting(0);
include_once("dbconnect.php");
$imagesid = $_POST['imagesid'];

$sql = "DELETE FROM IMAGES WHERE PROID = $imagesid" ;
    if ($conn->query($sql) === TRUE){
        echo "Deleted Successfully";
    }else {
        echo "Deletion Failed";
    }

$conn->close();
?>