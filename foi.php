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

    //administrator
    if (isset($_SESSION['user']) && in_array("administrator", $_SESSION['user'])) {
        $logoutButtonDisplay = "inline";
        $loginButtonDisplay = "none";
        $signinButtonDisplay = "none";
        $foiForm = "inline";
        $timeConfigurationForm = "inline";
        $usersForm = "inline";
        //$moderators = getModerators();
        
        //form submited
        if(isset($_POST['submit']) && !empty($_POST['submit'])){
            
            //$moderatorID = $_POST['moderator'];
            $fieldOfInterest = $_POST['field-of-interest'];
            $description = $_POST['foi-description'];
            $themeId = $_POST['foi-theme'];
            saveFoi($fieldOfInterest,$description, $themeId);
    
        }
           
        $smarty = new Smarty();
        $smarty->assign("usersForm", $usersForm);
        $smarty->assign("timeConfigurationForm", $timeConfigurationForm);
        $smarty->assign("loginDisplay", $loginButtonDisplay);
        $smarty->assign("signinDisplay", $signinButtonDisplay);
        $smarty->assign("logoutDisplay", $logoutButtonDisplay);
        $smarty->assign("themes", getAllThemes());
        $smarty->display("templates/foi.tpl");
        
    }
    else{
        $location = "index.php";
        header("Loation: $location");
    }
     
    function saveFoi($fieldOfInterest, $description, $themeId){
        $db = new DataBase();
        $db->openConnectionDB();
        $sql = "INSERT INTO interesi (izgled_stranice_id, naziv, opis) VALUES ($themeId, '".$fieldOfInterest."', '".$description."')";
        $db->insertDB($sql);
        $db->closeConnectionDB();
    }
    
    function getAllThemes(){
        $db = new Database();
        $db->openConnectionDB();
        $sql = "SELECT *FROM izgled_stranica";
        $result = $db->selectDB($sql);
        $arrayTheme = [];
        while($row = mysqli_fetch_array($result)){
            $key = $row['id_izgled_stranice'];
            $value = $row['naziv_izgleda'];
            $arrayTheme = array_push_associative($arrayTheme,$key,$value);
        }
        $db->closeConnectionDB();
        return $arrayTheme;
    }
    
    function array_push_associative($array, $key, $value) {
    $array[$key] = $value;
    return $array;
}

?>