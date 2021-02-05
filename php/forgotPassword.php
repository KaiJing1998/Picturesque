<?php

    include_once('dbconnect.php');

    $email = $_POST['email'];
    $otp = '0';
    $sql = "SELECT * FROM USER WHERE EMAIL = '$email' AND OTP = '$otp'";
    $result = $conn->query($sql);
        if($result -> num_rows > 0) {
            sendEmail($email);
            echo "Success";
        } else {
            echo "Failed";
        }


function sendEmail($useremail) {
    $to      = $useremail; 
    $subject = 'Reset Password for Picturesque'; 
    $message = 'http://techvestigate.com/picturesque/php/changepw.php?email='.$useremail; 
    $headers = 'From: noreply@picturesque.com.my' . "\r\n" . 
    'Reply-To: '.$useremail . "\r\n" . 
    'X-Mailer: PHP/' . phpversion(); 
    mail($to, $subject, $message, $headers); 
}

?>
