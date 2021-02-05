<?php
error_reporting(0);
include_once("dbconnect.php");

$imagescover = $_POST['imagescover'];

$sql = "SELECT * FROM COMMENTS LEFT JOIN USER ON COMMENTS.USERNAME = USER.USERNAME WHERE COMMENTS.IMAGECOVER = '$imagescover'";

$result = $conn->query($sql);

if($result -> num_rows >0){
    $response ["comments"]=array();
    while($row=$result -> fetch_assoc()){
        $commentlist =array();
        $commentlist [commentid]=$row["COMMENTID"];
        $commentlist [imagescover]=$row["IMAGECOVER"];
        $commentlist [username]=$row["USERNAME"];
        $commentlist [comment]=$row["COMMENT"];
        $commentlist [email]=$row["EMAIL"];
       
        array_push($response["comments"],$commentlist);
    }
    echo json_encode($response);
}else{
    echo "nodata";
}

?>