<?php
    include ("../database.class.php");
    include ("../paging.class.php");

    $pg = new Paging();
    $resultsPerPage = $pg->getResultsPerPage();
    $numberOfPages = $pg->getNumberOfPages("korisnici");

    $page = 1;
    //set current page
    if (isset($_POST['page'])) {
        $page = $_POST['page'];
    }

    //setting limit for the results on the displayed page
    $startingLimitNumber = ($page - 1) * $resultsPerPage;
    
    $sql = "";
    $userArray = [];
    $arrayOrders = [];
    
    if(isset($_POST['username']) && isset($_POST['lastname']) && isset($_POST['firstname']) && isset($_POST['email']) && isset($_POST['password']) && isset($_POST['type'])){
     
        $arrayOrders = array_push_associative($arrayOrders, "korisnicko_ime", $_POST['username']);
        $arrayOrders = array_push_associative($arrayOrders, "prezime", $_POST['lastname']);
        $arrayOrders = array_push_associative($arrayOrders, "ime", $_POST['firstname']);
        $arrayOrders = array_push_associative($arrayOrders, "email", $_POST['email']);
        $arrayOrders = array_push_associative($arrayOrders, "lozinka", $_POST['password']);
        $arrayOrders = array_push_associative($arrayOrders, "vrsta_korisnika_id", $_POST['type']);
    }
    
    // set base sql structure
    if($_POST['key-words'] != -1){
        $keyWords = $_POST['key-words'];
        $sql = "SELECT *FROM korisnici WHERE ime LIKE '%$keyWords%' OR prezime LIKE '%$keyWords%' OR korisnicko_ime LIKE '%$keyWords%' OR email LIKE '%$keyWords%'";
    } 
    else{
        $sql = "SELECT *FROM korisnici";
    }
 
    //add ascending or descending order by
    if($_POST['username'] != 'none' ||$_POST['lastname'] != 'none' ||$_POST['firstname'] != 'none' || $_POST['email'] != 'none' || $_POST['password'] != 'none' || $_POST['type'] != 'none' ){
        $sql.= " ORDER BY ";
           
        $counter = 0;
        $arraySize = getCount($arrayOrders);
        foreach($arrayOrders as $column => $order){
            if($order != 'none'){
                if($counter != $arraySize && $counter != 0){
                    $sql.= ", ".$column." ".$order;
                }
                else{
                    $sql.= " ".$column." ".$order;
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

        array_push($userArray, array("username" => $username, "lastname" => $lastName, "firstname" => $firstName, "email" => $email, "password" => $password, "type" => $type));
    }


    //return json
    echo json_encode($userArray);
    
   
    function array_push_associative($array, $key, $value){
        $array[$key] = $value;
        return $array;
    }
    
    //get the number of columns that needs to be sort
    function getCount($arrayOrders){
        $count = 0;
        foreach($arrayOrders as $key =>$value){
            if($value != 'none'){
                $count++;
            }
        }
        return $count;
    }
?>
