<?php
    include ("../database.class.php");
    include ("../paging.class.php");
    
    $userArray = [];

    $db = new DataBase();
    $db->openConnectionDB();
    
    $pg = new Paging();
    $resultsPerPage = $pg->getResultsPerPage();
    $numberOfPages = $pg->getNumberOfPages("korisnici");
    
     
    $page = 1;
    //set current page
    if(isset($_POST['page'])){
        $page = $_POST['page'];
    }
   
    
    //setting limit for the results on the displayed page
    $startingLimitNumber = ($page-1)*$resultsPerPage;
    
    $sql = "SELECT *FROM korisnici LIMIT $startingLimitNumber, $resultsPerPage";
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
    
    //return json
    echo json_encode($userArray);
    
?>
