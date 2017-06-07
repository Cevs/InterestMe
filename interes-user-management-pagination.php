<?php

include ("database.class.php");
include("session.class.php");
include ("paging.class.php");

Session::createSession();

//check if user is administrator
if (isset($_SESSION['user']) && in_array("administrator", $_SESSION['user'])) {
    $userArray = [];
    $keyWords = -1;
    $sql = "";
    $arrayOrders = [];
  
    $page = 1;
    //set current page
    if (isset($_POST['page'])) {
        $page = $_POST['page'];
    }
    //paging
    $pg = new Paging();
    $resultsPerPage = $pg->getResultsPerPage();
   
    //setting limit for the results on the displayed page
    $startingLimitNumber = ($page - 1) * $resultsPerPage;

     //Save sorting orders of specific column to a array
    //key = column name in database   value = ASC || DESC || none
    if (isset($_POST['username']) && isset($_POST['interes']) && isset($_POST['moderator']) && isset($_POST['date'])) {
        $arrayOrders = array_push_associative($arrayOrders, "korisnicko_ime", $_POST['username']);
        $arrayOrders = array_push_associative($arrayOrders, "naziv", $_POST['interes']);
        $arrayOrders = array_push_associative($arrayOrders, "moderator", $_POST['moderator']);
        $arrayOrders = array_push_associative($arrayOrders, "datum", $_POST['date']); 
    }

     // set base sql structure
    if($_POST['key-words'] != -1){
        $keyWords = $_POST['key-words'];
        
        
        $sql = "SELECT k.korisnicko_ime, i.naziv, ik.moderator, ik.datum FROM interes_korisnika ik JOIN korisnici k ON "
                ." k.id_korisnik = ik.id_korisnik JOIN interesi i ON i.id_interes = ik.id_interes "
                . " WHERE k.korisnicko_ime LIKE '%$keyWords%' OR i.naziv LIKE '%$keyWords%' OR ik.datum LIKE '%$keyWords%'";
    } 
    else{
         $sql = "SELECT k.korisnicko_ime, i.naziv, ik.moderator, ik.datum FROM interes_korisnika ik JOIN korisnici k ON"
                 . " k.id_korisnik = ik.id_korisnik JOIN interesi i ON i.id_interes = ik.id_interes";
    }

    
    //add ascending or descending order by
    if ($_POST['username'] != 'none' || $_POST['interes'] != 'none' || $_POST['moderator'] != 'none' || $_POST['date'] != 'none') {
        $sql.= " ORDER BY ";
        $counter = 0;
        $arraySize = getCount($arrayOrders);
        foreach ($arrayOrders as $column => $order) {
            if ($order != 'none') {
                if ($counter != $arraySize && $counter != 0) {
                    $sql.= ", " . $column . " " . $order;
                } else {
                    $sql.= " " . $column . " " . $order;
                }
                $counter++;
            }
        }
    }

   
    //Add number of return rows 
    $sql.= " LIMIT $startingLimitNumber, $resultsPerPage";

    $db = new DataBase();
    $db->openConnectionDB();
    $result = $db->selectDB($sql);


    while ($row = mysqli_fetch_array($result)) {
        $username = $row['korisnicko_ime'];
        $interes = $row['naziv'];
        $moderator = ($row['moderator']==1)?"Yes":"No";
        $date = $row['datum'];

        //prepeare array with sql result
        array_push($userArray, array("username" => $username, "interes" => $interes, "moderator" => $moderator, "date" => $date));
    }
    //return json
    $db->closeConnectionDB();
    echo json_encode($userArray);
} else {
    $location = "index.php";
    header("Location: $location");
}



function array_push_associative($array, $key, $value) {
    $array[$key] = $value;
    return $array;
}

//get the number of columns that needs to be sort
function getCount($arrayOrders) {
    $count = 0;
    foreach ($arrayOrders as $key => $value) {
        if ($value != 'none') {
            $count++;
        }
    }

    return $count;
}

?>
