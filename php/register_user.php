<?php
include_once("dbconnect.php");
$name = $_POST['username'];
$email = $_POST['email'];
$password = sha1($_POST['password']);
$otp = rand(1000,9999);

$sqlregister = "INSERT INTO USER(USERNAME,EMAIL,PASSWORD,OTP) VALUES('$username','$email','$password','$otp')";

if ($conn->query($sqlregister) === TRUE){
    sendEmail($otp,$email);
    echo "Success";
}else{
    echo "Fail";
}

function sendEmail($otp,$email){
    $from = "noreply@techvestigate.com";
    $to = $email;
    $subject = "From Techvestigate. Verify your account";
    $message = "Use the following link to verify your account :"."\n http://techvestigate.com/picturesque/php/verify_account.php?email=".$email."&key=".$otp;
    $headers = "From:" . $from;
    mail($email,$subject,$message,$headers);
}




?>