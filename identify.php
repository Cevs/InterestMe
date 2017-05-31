<?php
    include ('libraries/Smarty/libs/Smarty.class.php');
    include ("database.class.php");
    $smarty = new Smarty();
    if(isset($_POST['submit'])){
       if(isset($_POST['password-reset-email']) && !empty($_POST['password-reset-email'])){
        $email = $_POST['password-reset-email'];
        
        $db = new DataBase();
        $db->openConnectionDB();
        $sql = "SELECT *FROM korisnici WHERE email = '".$email."'";
        $result = $db->selectDB($sql);
        if(mysqli_num_rows($result)!=0){
            $password = generateNewPassword();
            sendEmail($email, $password);
            
            $salt = "5aPn3v*z4!1bN<x4i&3";
            $hash = hash('sha256', $password.$salt);
            
            $sqlUpdate = "UPDATE  korisnici SET lozinka = '".$password."', kriptirana_lozinka = '".$hash."' WHERE email = '".$email."'";
            $db->updateDB($sqlUpdate);
        }
        $db->closeConnectionDB();
        
        } 
    }
   
    
    
    
    function generateNewPassword(){
         //Generate a new password and make sure that the password contains at least two capital letters, two lowercase letters, and check if contains between 5 and 15 letters
         do{
            $password = randomPassword();
         }while(checkPassword($password) != 1);  
         
         return $password;
    }
    
    function randomPassword() {
        $alphabet = "abcdefghijklmnopqrstuwxyzABCDEFGHIJKLMNOPQRSTUWXYZ0123456789";
        $pass = array(); 
        $alphaLength = strlen($alphabet) - 1;
        $length = mt_rand(5,15);
        for ($i = 0; $i < $length; $i++) {
            $n = rand(0, $alphaLength);
            $pass[] = $alphabet[$n];
        }
        return implode($pass); //turn the array into a string
    }
    
    function checkPassword($password){
        return preg_match('/^(?=(.*[\d]){1,})(?=(.*[a-z]){2,})(?=(.*[A-Z]){2,})(?:[\da-zA-Z]){5,15}$/',$password);
    }
        
    
    function sendEmail($email,$password){
        $to = $email;
        $subject = "Reset Password";
        $body = "Your new password is : $password";
        $from = "From: alemartin@foi.hr";
        mail($to,$subject,$body,$from);
    }
    
    
    $smarty->assign("title","Find Your Account");
    $smarty->assign("message","Please enter your email address");
    $smarty->display("templates/identify.tpl");
?>