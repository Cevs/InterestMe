<?php

include ("database.class.php");
include("session.class.php");
include ("paging.class.php");

Session::createSession();

//check if user is administrator
if (isset($_SESSION['user']) && in_array("administrator", $_SESSION['user'])) {
    $foiArray = [];
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
    if (isset($_POST['name']) && isset($_POST['page-style']) && isset($_POST['moderators']) && isset($_POST['users'])) {
        $arrayOrders = array_push_associative($arrayOrders, "naziv", $_POST['name']);
        $arrayOrders = array_push_associative($arrayOrders, "naziv_izgleda", $_POST['page-style']);
        $arrayOrders = array_push_associative($arrayOrders, "moderators", $_POST['moderators']);
        $arrayOrders = array_push_associative($arrayOrders, "users", $_POST['users']);
        $arrayOrders = array_push_associative($arrayOrders, "discussions", $_POST['discussions']);
    }

     // set base sql structure
    if($_POST['key-words'] != -1){
        $keyWords = $_POST['key-words'];
        
        
        $sql = "SELECT i.naziv, i.opis, s.naziv_izgleda, COUNT(case when ik.moderator = 1 then ik.id_interes else NULL end) as 'moderators', "
                ." COUNT(case when ik.moderator = 0 then ik.id_interes else NULL end) as 'users', (SELECT COUNT(*) FROM diskusije WHERE interes_id = i.id_interes) as 'discussions'"
                ." FROM interesi i JOIN izgled_stranica s ON i.izgled_stranice_id = s.id_izgled_stranice  JOIN interes_korisnika ik ON ik.id_interes = i.id_interes "
                ." JOIN diskusije d ON d.interes_id = i.id_interes"
                ." WHERE i.naziv LIKE '%$keyWords%' OR i.opis LIKE '%$keyWords%' OR s.naziv_izgleda LIKE '%$keyWords%'"
                ." GROUP BY i.naziv";
    } 
    else{
         $sql = "SELECT i.naziv, i.opis, s.naziv_izgleda, COUNT(case when ik.moderator = 1 then ik.id_interes else NULL end) as 'moderators', "
                ." COUNT(case when ik.moderator = 0 then ik.id_interes else NULL end) as 'users', (SELECT COUNT(*) FROM diskusije WHERE interes_id = i.id_interes) as 'discussions'"
                ." FROM interesi i JOIN izgled_stranica s ON i.izgled_stranice_id = s.id_izgled_stranice  JOIN interes_korisnika ik ON ik.id_interes = i.id_interes "
                ." JOIN diskusije d ON d.interes_id = i.id_interes GROUP BY i.naziv";
    }

    
    //add ascending or descending order by
    if ($_POST['name'] != 'none' || $_POST['page-style'] != 'none' || $_POST['moderators'] != 'none' || $_POST['users'] != 'none' || $_POST['discussions'] != 'none') {
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
        $name = $row['naziv'];
        $description = $row['opis'];
        $pageStyle = $row['naziv_izgleda'];
        $moderators = $row['moderators'];
        $users = $row['users'];
        $discussions = $row['discussions'];


    
        array_push($foiArray, array("name" => $name, "description" => $description, "style" => $pageStyle, "moderators" => $moderators,
            "users" => $users, "discussions" =>  $discussions));
    }
    //return json
    $db->closeConnectionDB();
    echo json_encode($foiArray);
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
