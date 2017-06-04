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
        $moderators = getModerators();
        
        //form submited
        if(isset($_POST['submit']) && !empty($_POST['submit'])){
            
            $moderatorID = $_POST['moderator'];
            $fieldOfInterest = $_POST['field-of-interest'];
            $description = $_POST['foi-description'];
            save($moderatorID,$fieldOfInterest,$description);
            
              $idmoderator = $moderatorID;
            $naziv = $fieldOfInterest;
            $opis = $description;
            
        }
        
        
        $smarty = new Smarty();
        $smarty->assign("usersForm", $usersForm);
        $smarty->assign("timeConfigurationForm", $timeConfigurationForm);
        $smarty->assign("loginDisplay", $loginButtonDisplay);
        $smarty->assign("signinDisplay", $signinButtonDisplay);
        $smarty->assign("logoutDisplay", $logoutButtonDisplay);
        $smarty->assign("moderators",$moderators);
        $smarty->display("templates/foi.tpl");
        
    }
    else{
        $location = "index.php";
        header("Loation: $location");
    }
    
    
    
     function getModerators(){
        $arrayModerators = [];
        $db = new DataBase();
        $db->openConnectionDB();
        $sql = "SELECT *FROM korisnici k JOIN vrste_korisnika v ON k.vrsta_korisnika_id = v.id_vrsta WHERE v.vrsta = 'moderator'";
        $result = $db->selectDB($sql);
        
        while ($row = mysqli_fetch_array($result)) {
            $id = $row['id_korisnik'];
            $firstname = $row['ime'];
            $lastname = $row['prezime'];          
            array_push($arrayModerators, array("firstname" => $firstname, "lastname" =>$lastname, "id"=>$id));
            
        }
        $db->closeConnectionDB();
        return $arrayModerators;
    }
    
    
    function save($moderatorID,$fieldOfInterest,$description){
        $db = new DataBase();
     
        $pageDesign = 1 ;// 1 -normal design (color of font black, background white, family font : Times new roman
        $sql = "INSERT INTO interesi (izgled_stranice_id, naziv, opis) VALUES ($pageDesign, '".$fieldOfInterest."', '".$description."')";
        $interesID = $db->insertDB($sql);
        
        $virutal = new VirtualTime();
        $virtualTime = $virutal->getVirtualTime();
        $date = date("Y-m-d H:i:s", strtotime($virtualTime));
        $sql = "INSERT INTO interes_korisnika (id_interes, id_korisnik, moderator, datum) VALUES ($interesID, $moderatorID, 1, '".$date."')";
        $db->insertDB($sql);
        
  
    }
?>