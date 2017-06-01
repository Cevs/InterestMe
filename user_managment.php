<?php
    include ('libraries/Smarty/libs/Smarty.class.php');
    include ("database.class.php");
    include("session.class.php");
    
  
    
    Session::createSession();
    
    //check if user is administrator
    if(isset($_SESSION['user']) && in_array("administrator", $_SESSION['user'])){
        $db = new DataBase();
        $db->openConnectionDB();
        
        if(isset($_POST['chk_unlock']) && !empty($_POST['chk_unlock'])){
            foreach($_POST['chk_unlock'] as $i => $value){
                $username = $value;
                $sqlUpdate = "UPDATE korisnici SET zakljucan_pristup = 0, neuspjesne_prijave = 0 WHERE korisnicko_ime  = '".$username."'";
                $db->updateDB($sqlUpdate);
            }
        }
        
        if(isset($_POST['chk_lock']) && !empty($_POST['chk_lock'])){
            foreach($_POST['chk_lock'] as $i => $value){
                $username = $value;
                $sqlUpdate = "UPDATE korisnici SET zakljucan_pristup = 1 WHERE korisnicko_ime  = '".$username."'";
                $db->updateDB($sqlUpdate);
            }
        }
        
        $lockedUsers = array();
            
      
        $sql = "SELECT *FROM korisnici k JOIN vrste_korisnika v ON k.vrsta_korisnika_id = v.id_vrsta WHERE v.vrsta !='administrator'";
        $result = $db->selectDB($sql);
            
        while($row = mysqli_fetch_array($result)){
            $firstName = $row['ime'];
            $lastName = $row['prezime'];
            $username = $row['korisnicko_ime'];
            $numberOfAttemps = $row['neuspjesne_prijave'];
            $registerDate = $row['datum_registriranja'];
            $email = $row['email'];
            
            if($row['zakljucan_pristup']==1){
                $status = "LOCKED";
            }
            else{
                $status = "UNLOCKED";
            }
        
                
            array_push($lockedUsers, array("firstname"=>$firstName, "lastname"=>$lastName, "username"=>$username, "email"=>$email,
                "registerdate"=>$registerDate, "numberofattemps"=>$numberOfAttemps, "status"=>$status));
        }
            
        $db->closeConnectionDB();
            
        $smarty = new Smarty();
        $smarty->assign('lockedusers',$lockedUsers);
        $smarty->display('templates/user_managment.tpl');
              
    }
    else{
        $location = "index.php";
        header("Location: $location");
    }

?>