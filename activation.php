<?php
    require ("database.class.php");
    include ('libraries/Smarty/libs/Smarty.class.php');
    include ("virtual_time.class.php");
    
    if(isset($_GET["activationcode"]) && !empty($_GET["activationcode"])){
        
        $smarty = new Smarty();
        $idUser = -1;
        $expirationDate = "";
        $username = "";
        $activationCode = $_GET["activationcode"];
        $db = new DataBase();
        $db->openConnectionDB();
        $sql = "SELECT id_korisnik, korisnicko_ime, vrijeme_isteka_aktivacijskog_koda FROM korisnici WHERE aktivacijski_kod = '".$activationCode."'";
        $result =  $db->selectDB($sql);
   
        
        if(mysqli_num_rows($result) == 1){
           while($row = mysqli_fetch_array($result)){
               $idUser = $row["id_korisnik"];
               $expirationDate = $row['vrijeme_isteka_aktivacijskog_koda'];
               $username = $row['korisnicko_ime'];
           }
        }
        
        //User account exist
        if($idUser != -1)
        {
            $virtual = new VirtualTime();
            $virtualTime = $virtual->getVirtualTime();
        
            if($virtualTime <= $expirationDate ){
                $sql = "UPDATE korisnici SET status_korisnickog_racuna = 'AKTIVIRAN' WHERE id_korisnik = "
                       ."$idUser AND korisnicko_ime = '".$username."' AND aktivacijski_kod = '".$activationCode."';";
                $db->updateDB($sql);
                $smarty->assign("title","Successful Registration...");
                $smarty->assign("message","Congratulations you have successfully registered and now you are able to use the application!");
                $smarty->assign("link","login.php");
                $smarty->assign("link_message","Click here to login");
                $smarty->display("templates/activation.tpl");
            }
             else{
                $sql = "DELETE FROM korisnici WHERE id_korisnik = $idUser AND korisnicko_ime = '".$username."' AND aktivacijski_kod = '".$activationCode."';";
                $db->updateDB($sql);
                $smarty->assign("title","Ooops... Your activation link has expired !!!");
                $smarty->assign("message","Your account will be deleted. Register again and confirm your registration.");
                $smarty->assign("link","register.php");
                $smarty->assign("link_message","Click here to register");
                $smarty->display("templates/activation.tpl");
      
            }

 
        }
        //User account doesn't exist
        else{
            $smarty->assign("title","Activation link  NOT valid !!!");
            $smarty->assign("message","An activation link is not associated with any user account.");
            $smarty->assign("link","register.php");
            $smarty->assign("link_message","Click here to register");
            $smarty->display("templates/activation.tpl");
        }
        
        $db->closeConnectionDB();
        
    }//if end
    else{
        $location = "index.php";
        header("Location: $location");
    }
?>