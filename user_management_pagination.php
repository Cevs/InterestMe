<?php

    include ("database.class.php");
    include("session.class.php");
    include ("paging.class.php");


    Session::createSession();

    //check if user is administrator
    if (isset($_SESSION['user']) && in_array("administrator", $_SESSION['user'])) {
        $userArray = [];
        $sqlUpdateResult ="";
        
       $result= "";

        $pg = new Paging();
        $resultsPerPage = $pg->getResultsPerPage();
        $numberOfPages = $pg->getNumberOfPages("korisnici") - 1;
        $db = new DataBase();
        $db->openConnectionDB();

        $page = 1;
        //set current page
        if (isset($_POST['page'])) {
            $page = $_POST['page'];
        }

        
        if (isset($_POST['chk_lock'])) {
            $lockArray = (Array)json_decode($_POST['chk_lock'],true);
            lockUsers($lockArray);
          
      
        }

        if (isset($_POST['chk_unlock'])) {
            $unlockArray = (Array)json_decode($_POST['chk_unlock'],true);
            unlockUsers($unlockArray);

        }
        
 

 

        //setting limit for the results on the displayed page
        $startingLimitNumber = ($page - 1) * $resultsPerPage;

        $sql = "SELECT *FROM korisnici k JOIN vrste_korisnika v ON k.vrsta_korisnika_id = v.id_vrsta WHERE v.vrsta !='administrator' LIMIT $startingLimitNumber, $resultsPerPage";
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

            array_push($userArray, array("firstname" => $firstName, "lastname" => $lastName, "username" => $username, "email" => $result,
                "registerdate" => $registerDate, "numberofattemps" => $numberOfAttemps, "status" => $status));
        }
        //return json
        $db->closeConnectionDB();
        echo json_encode($userArray);
    } else {
        $location = "index.php";
        header("Location: $location");
    }

    function lockUsers($lockArray){
        $dbb = new Database();
        $dbb->openConnectionDB();
        $result = "";
        foreach ($lockArray as $value) {

            $username = trim($value);
            $sqlUpdate = "UPDATE korisnici SET zakljucan_pristup = 1 WHERE korisnicko_ime  = '" . $username . "'";
            $result = $dbb->updateDB($sqlUpdate);
                
            //$sql = "INSERT INTO proba2 (json) VALUES('".$username."')";
            //$db->insertDB($sql);
  
        }
        $dbb->closeConnectionDB();
        return $result;
    }
    
    
    function unlockUsers($unlockArray){
        $result = "";
        $dbb = new Database();
        $dbb->openConnectionDB();
        foreach ($unlockArray as  $value) {       
            $username = trim($value);
            $sqlUpdate = "UPDATE korisnici SET zakljucan_pristup = 0, neuspjesne_prijave = 0 WHERE korisnicko_ime  = '" . $username . "'";
            $result = $dbb->updateDB($sqlUpdate);   
                
        }
        
        $dbb->closeConnectionDB();
        return $result;
    }
?>
