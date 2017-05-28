<?php
    include ('libraries/Smarty/libs/Smarty.class.php');
    include ("database.class.php");
    include("session.class.php");
    
    $errorArray =  [];
    $link = "";
    
    if (isset($_POST['submit'])){
 
        $inputField = array('first-name', 'last-name', 'email', 'username', 'password', 'confirm');
        $error = false;
        
        
        foreach ($inputField AS $fieldName) {
            if(!isset($_POST[$fieldName]) || empty($_POST[$fieldName])){
                $error = true;
                array_push($errorArray, "Field $fieldName is empty");
            }
            else{
                if(checkForSpecialChars($_POST[$fieldName])){
                     $error = true;
                     array_push($errorArray, "Field $fieldName contains special chars");
                }
            }
        }
        
        
        if(passwordVerification($_POST["password"])!= 1){
            $error = true;
            array_push($errorArray, "The password is not in the correct form");
        }
        
        //check if password and confirm password are identical
         if(!(($_POST["password"]==$_POST["confirm"]))){
            $error = true;
            array_push($errorArray, "Password and confirm password are not indentical");
        }
        
         if(emailVerification($_POST["email"])!=1){
            $error = true;
            array_push($errorArray, "Wrong format of email");
        }
        
         if(isset($_POST["username"]) && isset($_POST["email"]) && !empty($_POST["username"])&& !empty($_POST["email"])){
            if(usernameExists()){
                $error = true;
                array_push($errorArray, "Username already in use");
            }
        }
        
        //reCapcha check
        if(!(isset($_POST["g-recaptcha-response"]) && !empty($_POST["g-recaptcha-response"]))){
           $secret = "6LfyJiMUAAAAAC7a8H1jCpgIvgIpORu3NxyDHd98";
           $ip = $_SERVER['REMOTE_ADDR'];
           $reCaptcha = $_POST['g-recaptcha-response'];
           $response = file_get_contents("https://www.google.com/recaptcha/api/siteverify?secret=$secret&response=$$reCaptcha&remoteip=$ip");
           $arr = json_decode($response,TRUE);
           if(!$arr['success']){
               $error = true;
               array_push($errorArray, "reCapatcha missing");
           }
       }
       
       if(!$error){
           $db = new DataBase();
           $twoStepLogin = isset($_POST['checkbox-registration'])?1:0;
           
           $salt = "5aPn3v*z4!1bN<x4i&3";
           $password = $_POST['password'];
           $hash = hash('sha256', $password.$salt);
           
           $activationCode = generateActivationCode();
           
           $link = "http://barka.foi.hr/WebDiP/2016_projekti/WebDiP2016x079/activation.php?activationcode=$activationCode";
           
      
           
           $date = date('Y-m-d'); //pr. 2012-03-06
           $codeExpiration = date('Y-m-d H:i:s', strtotime('5 hour'));
      
           
           
           $sql = "INSERT INTO korisnici (ime, prezime, email, korisnicko_ime, lozinka, kriptirana_lozinka, datum_registriranja, dvorazinska_prijava, aktivacijski_kod, "
                  . "vrijeme_isteka_aktivacijskog_koda, status_korisnickog_racuna, vrsta_korisnika_id, neuspjesne_prijave) VALUES ('".$_POST['first-name']."', '".$_POST['last-name']."', '".$_POST['email']."', '".$_POST['username']
                  ."', '".$_POST['password']."', '".$hash."', '".$date."', $twoStepLogin, '".$activationCode."', '".$codeExpiration."', 'NIJE AKTIVIRAN', 1, 0)";
           
           $db->insertDB($sql);
          
           sendEmail($link, $_POST['email']);
       }
        
       
    }
    
     function passwordVerification($password){
        return preg_match('/^(?=(.*[\d]){1,})(?=(.*[a-z]){2,})(?=(.*[A-Z]){2,})(?:[\da-zA-Z]){5,15}$/',$password);
    }
    
    function emailVerification($email){
        return preg_match('/(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)/',$email);
    }
    
    
    function checkForSpecialChars($fieldName) {
        return preg_match('/[\(\)\{\}\\/!#"]/', $fieldName);
    }
    
    
    function usernameExists(){
        $exists = true;
        $db = new DataBase();
        $db->openConnectionDB();
        $sql = "SELECT *FROM korisnici WHERE korisnicko_ime = '".$_POST["username"]."' OR email = '".$_POST["email"]."';";
        $result = $db->selectDB($sql);
        
        if(mysqli_num_rows($result)==0){
            $exists = false;
        }
        
        $db->closeConnectionDB();
        
        if($exists){
            return true;
        }
        else{
            return false;
        }
    }
    
    
     function generateActivationCode(){
     
        $date = date("j.n.Y");
        $time = date("h:i:s");
        $arrayDate = explode(".",$date);
        $arrayTime = explode(":",$time);
        
        $code = $arrayDate[0]."".$arrayDate[1]."".$arrayDate[2]."".$arrayTime[0]."".$arrayTime[1]."".$arrayTime[2]."".$_POST["username"];
        $salt = "k4?a9Z1_q#3&dxL>p*c";
        $hash = hash('sha256', $code.$salt);
        return $hash;
    }
    
     function sendEmail($link, $email){
        $to = $email;
        $subject = "Activation link";
        $body = "Click on  $link for activating account";
        $from = "From: alemartin@foi.hr";
       
        mail($to,$subject,$body,$from);
    }
       
    $smarty = new Smarty();
    //$smarty->assign("error_array", $errorArray);
    $smarty->display("templates/register.tpl");
 ?>