<?php

include ("database.class.php");
include("session.class.php");
include ("paging.class.php");

Session::createSession();

//check if user is administrator
if (isset($_SESSION['user']) && in_array("administrator", $_SESSION['user'])) {
    $couponArray = [];
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
    //key = column name in database   
    //value = ASC || DESC || none
    if (isset($_POST['name']) && isset($_POST['using'])) {
        $arrayOrders = array_push_associative($arrayOrders, "naziv", $_POST['name']);
        $arrayOrders = array_push_associative($arrayOrders, "broj_koristenja", $_POST['using']);
 
    }

     // set base sql structure
    if($_POST['key-words'] != -1){
        $keyWords = $_POST['key-words'];
        
        $sql = "SELECT kc.id_kupon_clanstva ,kc.naziv, kc.pdf, kc.slika, kc.video, (SELECT COUNT(*) FROM kuponi_interesa ki WHERE ki.kupon_clanstva_id = kc.id_kupon_clanstva) as 'broj_koristenja' "
                . " FROM kuponi_clanstva kc WHERE kc.naziv LIKE '%$keyWords%'";
 
    } 
    else{
         $sql = "SELECT kc.id_kupon_clanstva, kc.naziv, kc.pdf, kc.slika, kc.video, (SELECT COUNT(*) FROM kuponi_interesa ki WHERE ki.kupon_clanstva_id = kc.id_kupon_clanstva) as 'broj_koristenja'"
                 ." FROM kuponi_clanstva kc";
    }

    
    //add ascending or descending order by
    if ($_POST['name'] != 'none' || $_POST['using'] != 'none' ) {
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
        $id = $row['id_kupon_clanstva'];
        $name = $row['naziv'];
        $pdfPath = $row['pdf'];
        $imgPath = $row['slika'];
        $videoPath = $row['video'];
        $using = $row['broj_koristenja'];

        //prepeare array with sql result
        array_push($couponArray, array("id"=>$id, "name" => $name, "pdf" => $pdfPath, "img" => $imgPath, "video" =>$videoPath, "using" => $using));
    }
    //return json
    $db->closeConnectionDB();
    echo json_encode($couponArray);
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
