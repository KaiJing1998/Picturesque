<?php

include_once ("dbconnect.php");

$username = $_POST['commentusername'];
$comment = $_POST['comment'];
$imagecover = $_POST['imagecover'];
$time = $_POST['time'];

$sqlcomment = "INSERT INTO COMMENTS(IMAGECOVER, USERNAME, COMMENT, TIME) VALUES ('$imagecover', '$username', '$comment', '$time')";
   
if ($conn->query($sqlcomment) === TRUE){
    echo "success";
    return "success";
}else{
    echo "failed";
    return "failed";
}

?>