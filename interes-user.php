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
    $administrator = "none";
    $action = "";

    //administrator
    if (isset($_SESSION['user']) && in_array("administrator", $_SESSION['user'])) {
        $logoutButtonDisplay = "inline";
        $loginButtonDisplay = "none";
        $signinButtonDisplay = "none";
        $administrator = "inline";
      
         //Pressed update button on table
        if (isset($_GET['username']) && !empty($_GET['username']) && isset($_GET['interes']) && !empty($_GET['interes']) && isset($_GET['action']) && $_GET['action'] ==='update'){

            $username = $_GET['username'];
            $interes = $_GET['interes'];
            $data = getInteresUserData($username,$interes);
            $action = "update";
        }
        ///Pressed delete button on table
        else if (isset($_GET['username']) && !empty($_GET['username']) && isset($_GET['interes']) && !empty($_GET['interes']) && isset($_GET['action']) && $_GET['action'] ==='delete'){
                $username = $_GET['username'];
                $interes = $_GET['interes'];
                deleteInteresUser($username,$interes);
        }

        //Pressed button for inserting new user
         else if (isset($_GET['action'])&& $_GET['action']==='insert'){
            $action = "insert";  
         }
         
        //form submited
        if(isset($_POST['submit'])){
            
            $userID = $_POST['user-id'];
            $foiID = $_POST['interes-id'];
            $moderator = isset($_POST['moderator'])?1:0;
            $joinDate = $_POST['join-date'];

            
            //Form submitted for updating
            //Because select element is disabled we need to get id from hidden element
            if($_POST['action']==='update'){
                $userID = $_POST['user-update-id'];
                $foiID = $_POST['interes-update-id'];
                updateInteresUser($userID, $foiID, $moderator, $joinDate);
            }
              //Form submitted for inserting
            if($_POST['action']==='insert'){
                insertInteresUser($userID, $foiID, $moderator, $joinDate);
            }
    
        }
        //Set form data of selected user
        else if (isset($_GET['action']) && $_GET['action'] === 'update'){
            $smarty = new Smarty();

            foreach ($data as $name => $value) {
                $smarty->assign($name, $value);
            }
            $smarty->assign("action","update");
            //seting the id of user and interes to hidden element
            $smarty->assign("userUpdateID", getUsernameID($_GET['username']));
            $smarty->assign("interesUpdateID", getInteresID($_GET['interes']));

        }
        //set form data to empty
        else if(isset($_GET['action']) && $_GET['action'] === 'insert'){

            $smarty = new Smarty();
            //set fields of form to empty
            $smarty->assign("action","insert");
            $smarty->assign("username","");
            $smarty->assign("interes","");
            $smarty->assign("moderator","");
            $smarty->assign("date","");
            $smarty->assign("userUpdateID", "-1");
            $smarty->assign("interesUpdateID", "-1");

        }

        
        //Set common options and display form  
        $smarty->assign("administrator",$administrator);
        $smarty->assign("action",$action);
        $smarty->assign("loginDisplay", $loginButtonDisplay);
        $smarty->assign("signinDisplay", $signinButtonDisplay);
        $smarty->assign("logoutDisplay", $logoutButtonDisplay);
        $smarty->assign("users", getAllUsers());
        $smarty->assign("interests", getAllInterests());
        $smarty->display("templates/interes-user.tpl");
        
    }
    else{
        $location = "index.php";
        header("Loation: $location");
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
    
    function getAllUsers(){
        $db = new Database();
        $db->openConnectionDB();
        $sql = "SELECT *FROM korisnici";
        $result = $db->selectDB($sql);
        $arrayUsers = [];
        while($row = mysqli_fetch_array($result)){
            $key = $row['id_korisnik'];
            $value = $row['korisnicko_ime'];
            $arrayUsers = array_push_associative($arrayUsers,$key,$value);
        }
        $db->closeConnectionDB();
        return $arrayUsers;
    }
    
    function getAllInterests(){
        $db = new Database();
        $db->openConnectionDB();
        $sql = "SELECT *FROM interesi";
        $result = $db->selectDB($sql);
        $arrayInterests = [];
        while($row = mysqli_fetch_array($result)){
            $key = $row['id_interes'];
            $value = $row['naziv'];
            $arrayInterests = array_push_associative($arrayInterests,$key,$value);
        }
        $db->closeConnectionDB();
        return $arrayInterests;
    }
    
    function array_push_associative($array, $key, $value) {
        $array[$key] = $value;
        return $array;
    }
    
    function getInteresUserData($username,$interes) {
        $db = new DataBase();
        $db->openConnectionDB();
        
        $iID = getInteresID($interes);
        $uID = getUsernameID($username);

        $sql = "SELECT *FROM interes_korisnika WHERE id_interes = $iID AND id_korisnik = $uID";
        $result = $db->selectDB($sql);
        $array = [];

        $row = mysqli_fetch_array($result);
        $interesID = $row['id_interes'];
        $userID = $row['id_korisnik'];
        $interesName = getInteresName($interesID);
        $username = getUsername($userID);
     
        $moderator = $row['moderator'];
        $date = $row['datum'];

     
        $array = array_push_associative($array, "username", $username);
        $array = array_push_associative($array, "interes", $interesName);
        $array = array_push_associative($array, "moderator", $moderator);
        $array = array_push_associative($array, "date", $date);
       
        $db->closeConnectionDB();
        return $array;
    }
    
    
    
    
    function getInteresID($interes){
        $db = new DataBase();
        $db->openConnectionDB();
        $sql = "SELECT *FROM interesi WHERE naziv = '".$interes."'";
        $result = $db->selectDB($sql);
        $row = mysqli_fetch_array($result);
        
        $id = $row['id_interes'];
        $db->closeConnectionDB();
        
        return ($id);
    }
    
    function getUsernameID($username){
        $db = new DataBase();
        $db->openConnectionDB();
        $sql = "SELECT *FROM korisnici WHERE korisnicko_ime = '".$username."'";
        $result = $db->selectDB($sql);
        $row = mysqli_fetch_array($result);
        
        $id = $row['id_korisnik'];
        $db->closeConnectionDB();
        
        return ($id);
    }
    
    function getInteresName($interesID){
        $db = new DataBase();
        $db->openConnectionDB();

        $sql = "SELECT *FROM interesi WHERE id_interes = $interesID";
        $result = $db->selectDB($sql);

        $row = mysqli_fetch_array($result);
        $interes = $row['naziv'];

        $db->closeConnectionDB();
        return ($interes);
    }
    
    function getUsername($userID){
        $db = new DataBase();
        $db->openConnectionDB();

        $sql = "SELECT *FROM korisnici WHERE id_korisnik = $userID";
        $result = $db->selectDB($sql);

        $row = mysqli_fetch_array($result);
        $user = $row['korisnicko_ime'];

        $db->closeConnectionDB();
        return ($user);
    }
      
    function insertInteresUser($userID, $foiID, $moderator, $joinDate){
        $db = new DataBase();
        $db->openConnectionDB();
        $sql = "INSERT INTO interes_korisnika (id_interes, id_korisnik, moderator, datum) VALUES ($foiID, $userID, $moderator, '".$joinDate."')";
        $db->insertDB($sql);
        $db->closeConnectionDB();
        $location = "interes-user-management.php";
        header("Location: $location");
    }
    
    
    function updateInteresUser($userID, $foiID, $moderator, $joinDate) {
        $db = new DataBase();
        $db->openConnectionDB();

        $text = $userID." ".$foiID." ".$moderator." ".$joinDate;
        $insert = "INSERT INTO proba2 (json) VALUES ('".$text."')";
        $db->insertDB($insert);
        $sql = "UPDATE interes_korisnika SET moderator = $moderator, datum = '".$joinDate."' WHERE id_interes = $foiID AND id_korisnik = $userID";

        $db->updateDB($sql, "interes-user-management.php");

        $db->closeConnectionDB();
    }
    
    
    function deleteInteresUser($username,$interes) {
        $location = "interes-user-management.php";
        $db = new Database();
        $db->openConnectionDB();
        
        $uID = getUsernameID($username);
        $iID = getInteresID($interes);
        
        $sql = "DELETE FROM interes_korisnika WHERE  id_interes = $iID AND id_korisnik = $uID";
        $db->updateDB($sql, $location);
        $db->closeConnectionDB();
    }

?>

