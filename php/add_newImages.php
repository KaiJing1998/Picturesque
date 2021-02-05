<?php

include_once ("dbconnect.php");
$imagesdestination = $_POST['imagesdestination'];
$imagescollections = $_POST['imagescollections'];
$imagesauthor = $_POST['imagesauthor'];
$imagescaption = $_POST['imagescaption'];
$imagescover = $_POST['imagescover'];
$encoded_string = $_POST["encoded_string"];
$decoded_string = base64_decode($encoded_string);
$path = '../image/' . $imagescover . '.jpg';
$is_written = file_put_contents($path, $decoded_string);
 
if ($is_written > 0) {
    $sqlregister = "INSERT INTO IMAGES(DESTINATION, COLLECTIONS, AUTHOR, CAPTION, COVER) VALUES ('$imagesdestination', '$imagescollections', '$imagesauthor', '$imagescaption', '$imagescover')";
   
if ($conn->query($sqlregister) === TRUE){
    echo "success";
}else{
    echo "failed";
}
} else {
    echo "add failed";
}

?>