<?php

error_reporting(0);
include_once("dbconnect.php");
$email = $_POST['email'];

$sql = "SELECT * FROM IMAGES LEFT JOIN USER ON IMAGES.AUTHOR = USER.USERNAME WHERE USER.EMAIL = '$email'";

$result = $conn->query($sql);
if ($result->num_rows >0){
    $response ["images"]=array();
    while($row =$result->fetch_assoc()){
        $imageslist =array();
        $imageslist [imagesid]=$row["PROID"];
        $imageslist [imagesdestination]=$row["DESTINATION"];
        $imageslist [imagescollections]=$row["COLLECTIONS"];
        $imageslist [imagesauthor]=$row["AUTHOR"];
        $imageslist [imagescaption]=$row["CAPTION"];
        $imageslist [imagescover]=$row["COVER"];
        $imageslist [imagesemail]=$row["EMAIL"];
  
        array_push($response["images"],$imageslist);
    }
    echo json_encode($response);
}
else{
    echo "Cart Empty";
}




?>