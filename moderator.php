<?php

    require ('libraries/Smarty/libs/Smarty.class.php');
    include ('database.class.php');
    include ('session.class.php');
    include ("virtual_time.class.php");
    


    Session::createSession();

    //Configurations
    $logoutButtonDisplay = "none";
    $loginButtonDisplay = "inline";
    $signinButtonDisplay = "inline";
    $foiForm = "none"; //field of interest form
    $usersForm = "none";
    $timeConfigurationForm = "none";
    $moderators = [];
    
  
    //administrator
    if (isset($_SESSION['user']) && in_array("administrator", $_SESSION['user'])) {
        $logoutButtonDisplay = "inline";
        $loginButtonDisplay = "none";
        $signinButtonDisplay = "none";
        $foiForm = "inline";
        $timeConfigurationForm = "inline";
        $usersForm = "inline";

        
        //form submited
        if(isset($_POST['submit']) && !empty($_POST['submit'])){
            
            $firstName = $_POST['moderator-firstname'];
            $lastName = $_POST['moderator-lastname'];
            $email = $_POST['moderator-email'];
            $username = $_POST['moderator-username'];
            $password = $_POST['moderator-password'];
            $twoStepLogin = isset($_POST['moderator-two-step-login'])?1:0;
            $hashPasswod = GetHash($password);
            $date = ReturnDate();
            
            SaveModerator($firstName,$lastName,$email,$username,$password,$twoStepLogin,$hashPasswod,$date);
            
        }
        
        
        $smarty = new Smarty();
        $smarty->assign("usersForm", $usersForm);
        $smarty->assign("timeConfigurationForm", $timeConfigurationForm);
        $smarty->assign("loginDisplay", $loginButtonDisplay);
        $smarty->assign("signinDisplay", $signinButtonDisplay);
        $smarty->assign("logoutDisplay", $logoutButtonDisplay);
        $smarty->display("templates/moderator.tpl");
        
    }
    else{
        $location = "index.php";
        header("Loation: $location");
    }
    
    
    
  
    
    
    function GetHash($password){
        $salt = "5aPn3v*z4!1bN<x4i&3";
        $hash = hash('sha256', $password.$salt);
        
        return($hash);
    }
    
    function ReturnDate(){
        $virtual = new VirtualTime();
        $virtualTime = $virtual->getVirtualTime();
        $date = date("Y-m-d H:i:s", strtotime($virtualTime));
        return ($date);
    }
    
    function SaveModerator($firstName,$lastName,$email,$username,$password,$twoStepLogin,$hashPasswod,$date){
        $db = new DataBase();
        $typeOfUser = 2; // 1 - registered user 2 - Moderator 3 - administrator
        $sql = "INSERT INTO korisnici (vrsta_korisnika_id, ime, prezime, korisnicko_ime, email, lozinka, kriptirana_lozinka, datum_registriranja, dvorazinska_prijava) "
                . "VALUES ($typeOfUser, '".$firstName."', '".$lastName."', '".$username."', '".$email."', '".$password."', '".$hashPasswod."', '".$date."', $twoStepLogin)";
        $db->insertDB($sql);
    }
?>