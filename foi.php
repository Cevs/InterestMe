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
        if (isset($_GET['foiname']) && !empty($_GET['foiname']) && isset($_GET['action'])&& $_GET['action']==='update') {

            $foiname = $_GET['foiname'];
            $foiData = getFoiData($foiname);
            $action = "update";
        }
        ///Pressed delete button on table
        else if (isset($_GET['foiname']) && !empty($_GET['foiname'])&&isset($_GET['action'])&& $_GET['action']==='delete'){
                $foiname = $_GET['foiname'];
                deleteFoi($foiname);
        }

        //Pressed button for inserting new user
         else if (isset($_GET['action'])&& $_GET['action']==='insert'){
            $action = "insert";  
         }
         
        //form submited
        if(isset($_POST['submit'])){
            
            $id = $_POST['foi-id'];
            $fieldOfInterest = $_POST['field-of-interest'];
            $description = $_POST['foi-description'];
            $themeId = $_POST['foi-theme'];

            
            //Form submitted for updating
            if($_POST['action']==='update'){
                updateFoi($id, $themeId, $fieldOfInterest, $description);
            }
              //Form submitted for inserting
            if($_POST['action']==='insert'){
                insertFoi($id, $themeId, $fieldOfInterest, $description);
            }
    
        }
        //Set form data of selected user
        else if (isset($_GET['action']) && $_GET['action'] === 'update'){
            $smarty = new Smarty();

            foreach ($foiData as $name => $value) {
                $smarty->assign($name, $value);
            }

        }
        //set form data to empty
        else if(isset($_GET['action']) && $_GET['action'] === 'insert'){

            $smarty = new Smarty();
            //set fields of form to empty
            $smarty->assign("id","");
            $smarty->assign("name","");
            $smarty->assign("description","");
            $smarty->assign("theme","");

        }

        
        //Set common options and display form  
        $smarty->assign("action",$action);
        $smarty->assign("administrator",$administrator);
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
     
    function insertFoi($fieldOfInterest, $description, $themeId){
        $db = new DataBase();
        $db->openConnectionDB();
        $sql = "INSERT INTO interesi (izgled_stranice_id, naziv, opis) VALUES ($themeId, '".$fieldOfInterest."', '".$description."')";
        $db->insertDB($sql);
        $db->closeConnectionDB();
        $location = "foi-management.php";
        header("Location: $location");
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
    
    function getFoiData($foiname) {
        $db = new DataBase();
        $db->openConnectionDB();


        $sql = "SELECT *FROM interesi WHERE naziv = '".$foiname."'";
        $result = $db->selectDB($sql);
        $array = [];

        $row = mysqli_fetch_array($result);
        $id = $row['id_interes'];
        $style = getPageStyle($row['izgled_stranice_id']);
        $name = $row['naziv'];
        $description = $row['opis'];

        $array = array_push_associative($array, "id", $id);
        $array = array_push_associative($array, "style", $style);
        $array = array_push_associative($array, "name", $name);
        $array = array_push_associative($array, "description", $description);
       
        $db->closeConnectionDB();
        return $array;
    }
    
    
    //return title of page style
    function getPageStyle($pageStyleId) {
        $db = new DataBase();
        $db->openConnectionDB();

        $sql = "SELECT *FROM izgled_stranica WHERE id_izgled_stranice = $pageStyleId";
        $result = $db->selectDB($sql);

        $row = mysqli_fetch_array($result);
        $style = $row['naziv_izgleda'];

        $db->closeConnectionDB();
        return ($style);
    }
    
    
    function updateFoi($id, $themeId, $fieldOfInterest, $description) {
        $db = new DataBase();
        $db->openConnectionDB();
        $tekst = $id." ".$fieldOfInterest." ".$description." ".$themeId;
        $insert = "INSERT INTO proba2 (json) VALUES ('".$tekst."')";
        $db->insertDB($insert);
        $sql = "UPDATE interesi SET izgled_stranice_id = $themeId, naziv = '".$fieldOfInterest."', opis = '".$description."' WHERE id_interes = $id";

        $db->updateDB($sql, "foi-management.php");

        $db->closeConnectionDB();
    }
    
    
    function deleteFoi($foiname) {
        $location = "foi-management.php";
        $db = new Database();
        $db->openConnectionDB();
        $sql = "DELETE FROM interesi WHERE naziv = '" . $foiname . "'";
        $db->updateDB($sql, $location);
        $db->closeConnectionDB();
    }

?>