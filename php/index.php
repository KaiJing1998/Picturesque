<?php
// Import PHPMailer classes into the global namespace
// These must be at the top of your script, not inside a function
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;
use PHPMailer\PHPMailer\Exception;

// Load Composer's autoloader
require 'src/Exception.php';
require 'src/PHPMailer.php';
require 'src/SMTP.php';

// Instantiation and passing `true` enables exceptions
$mail = new PHPMailer(true);

include_once("dbconnect.php");
$name = $_POST['name'];
$email = $_POST['email'];
$password = sha1($_POST['password']);
// $imagename = $_POST['imagename'];
$encoded_string = $_POST["encoded_string"];
$decoded_string = base64_decode($encoded_string);
$path = '../../image/Profile/' . $email . '.jpg';
$is_written = file_put_contents($path, $decoded_string);
$otp = rand(1000, 9999);
// try {
//Server settings
$mail->SMTPDebug = 3;                      // Enable verbose debug output
$mail->isMail();                                            // Send using SMTP
$mail->Host       = 'mail.techvestigate.com';                    // Set the SMTP server to send through
$mail->SMTPAuth   = true;                                   // Enable SMTP authentication
$mail->Username   = 'picturesque@techvestigate.com';                     // SMTP username
$mail->Password   = 'No2ni!N;uoQ8';                               // SMTP password
$mail->SMTPSecure = 'SSL';         // Enable TLS encryption; `PHPMailer::ENCRYPTION_SMTPS` encouraged
$mail->Port       = 465;                                    // TCP port to connect to, use 465 for `PHPMailer::ENCRYPTION_SMTPS` above

if ($is_written > 0) {
    $sqlregister = "INSERT INTO USER(USERNAME,EMAIL,PASSWORD,OTP) VALUES('$name','$email','$password','$otp')";

    if ($conn->query($sqlregister) === TRUE) {
        echo "Success";
        //Recipients
        $mail->setFrom('picturesque@techvestigate.com', 'Picturesque');
        $mail->addAddress($email, 'Receiver');     // Add a recipient
        // Content
        $mail->isHTML(true);                                  // Set email format to HTML
        $mail->Subject = 'From Picturesque. Verify your account';
        $mail->Body    = 'Hello ' . $name . ',<br/><br/>Thank you for register with us,' . ' Please use the following link to verify your account : <br/><br/>http://techvestigate.com/picturesque/php/verify_account.php?email=' . $email . '&key=' . $otp;
        $mail->AltBody = 'This is the body in plain text for non-HTML mail clients';

        $mail->send();
    } else {
        echo "Fail";
    }
} else {
    echo "Save Image Failed";
}
