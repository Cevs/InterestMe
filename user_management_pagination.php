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

    if (isset($_POST['chk_lock'])) {
        $lockArray = (Array) json_decode($_POST['chk_lock'], true);
        lockUsers($lockArray);
    }

    if (isset($_POST['chk_unlock'])) {
        $unlockArray = (Array) json_decode($_POST['chk_unlock'], true);
        unlockUsers($unlockArray);
    }
    
    if (isset($_POST['firstname']) && isset($_POST['lastname']) && isset($_POST['username']) && isset($_POST['email']) && isset($_POST['registerdate']) && isset($_POST['attempts']) && isset($_POST['status'])) {
        $arrayOrders = array_push_associative($arrayOrders, "ime", $_POST['firstname']);
        $arrayOrders = array_push_associative($arrayOrders, "prezime", $_POST['lastname']);
        $arrayOrders = array_push_associative($arrayOrders, "korisnicko_ime", $_POST['username']);
        $arrayOrders = array_push_associative($arrayOrders, "email", $_POST['email']);
        $arrayOrders = array_push_associative($arrayOrders, "datum_registriranja", $_POST['registerdate']);
        $arrayOrders = array_push_associative($arrayOrders, "neuspjesne_prijave", $_POST['attempts']);
        $arrayOrders = array_push_associative($arrayOrders, "zakljucan_pristup", $_POST['status']);
    }

     // set base sql structure
    if($_POST['key-words'] != -1){
        $keyWords = $_POST['key-words'];
        $sql = "SELECT *FROM korisnici k JOIN vrste_korisnika v ON k.vrsta_korisnika_id = v.id_vrsta WHERE v.vrsta !='administrator' "
                . "AND(k.ime LIKE '%$keyWords%' OR k.prezime LIKE '%$keyWords%' OR k.korisnicko_ime LIKE '%$keyWords%' OR k.email LIKE '%$keyWords%' "
                . "OR v.vrsta LIKE '%$keyWords%')";
    } 
    else{
         $sql = "SELECT *FROM korisnici k JOIN vrste_korisnika v ON k.vrsta_korisnika_id = v.id_vrsta WHERE v.vrsta !='administrator'";
    }

    
    //add ascending or descending order by
    if ($_POST['firstname'] != 'none' || $_POST['lastname'] != 'none' || $_POST['username'] != 'none' || $_POST['email'] != 'none' || $_POST['registerdate'] != 'none' || $_POST['attempts'] != 'none' || $_POST['status'] != 'none') {
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
    $sqlInsert = "INSERT INTO proba2 (json) VALUES ('" . $sql . "')";
    $db->insertDB($sqlInsert);
    $result = $db->selectDB($sql);


    while ($row = mysqli_fetch_array($result)) {
        $firstName = $row['ime'];
        $lastName = $row['prezime'];
        $username = $row['korisnicko_ime'];
        $numberOfAttemps = $row['neuspjesne_prijave'];
        $registerDate = $row['datum_registriranja'];
        $email = $row['email'];

        if ($row['zakljucan_pristup'] == 1) {
            $status = "LOCKED";
        } else {
            $status = "UNLOCKED";
        }

        array_push($userArray, array("firstname" => $firstName, "lastname" => $lastName, "username" => $username, "email" => $email,
            "registerdate" => $registerDate, "numberofattemps" => $numberOfAttemps, "status" => $status));
    }
    //return json
    $db->closeConnectionDB();
    echo json_encode($userArray);
} else {
    $location = "index.php";
    header("Location: $location");
}

function lockUsers($lockArray) {
    $dbb = new Database();
    $dbb->openConnectionDB();

    foreach ($lockArray as $value) {

        $usernameLock = trim($value);
        $sqlUpdate = "UPDATE korisnici SET zakljucan_pristup = 1 WHERE korisnicko_ime  = '" . $usernameLock . "'";
        $dbb->updateDB($sqlUpdate);

        //$sql = "INSERT INTO proba2 (json) VALUES('".$username."')";
        //$db->insertDB($sql);
    }
    $dbb->closeConnectionDB();
}

function unlockUsers($unlockArray) {

    $dbb = new Database();
    $dbb->openConnectionDB();
    foreach ($unlockArray as $value) {
        $usernameUnlock = trim($value);
        $sqlUpdate = "UPDATE korisnici SET zakljucan_pristup = 0, neuspjesne_prijave = 0 WHERE korisnicko_ime  = '" . $usernameUnlock . "'";
        $dbb->updateDB($sqlUpdate);
    }

    $dbb->closeConnectionDB();
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
