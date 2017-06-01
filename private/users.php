<?php

    include ('../libraries/Smarty/libs/Smarty.class.php');
    include ("../database.class.php");

   
    
    $userArray = [];

    $db = new DataBase();
    $db->openConnectionDB();
    $sql = "SELECT *FROM korisnici";
    $result = $db->selectDB($sql);

    while ($userRow = mysqli_fetch_array($result)) {
       $firstName = $userRow["ime"];
       $lastName = $userRow["prezime"];
       $username = $userRow["korisnicko_ime"];
       $email = $userRow["email"];
       $password = $userRow["lozinka"];
       $typeId = $userRow["vrsta_korisnika_id"];
        
       $sql = "SELECT *FROM vrste_korisnika WHERE id_vrsta = $typeId";
       $resultType = $db->selectDB($sql);
       $typeRow = mysqli_fetch_array($resultType);
       
       $type = $typeRow["vrsta"];

       array_push($userArray, array("username"=>$username, "lastname"=>$lastName, "firstname"=>$firstName, "email"=>$email, "password"=>$password, "type"=>$type));
        
    }
    
    $db->closeConnectionDB();
    
    $smarty = new Smarty();
    $smarty->assign("user_array",$userArray);
    $smarty->display("../templates/users.tpl");
    
?>