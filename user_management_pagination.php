<?php

    include ("database.class.php");
    include("session.class.php");
    include ("paging.class.php");

    Session::createSession();

    //check if user is administrator
    if (isset($_SESSION['user']) && in_array("administrator", $_SESSION['user'])) {
        $userArray = [];

        $db = new DataBase();
        $db->openConnectionDB();

        $pg = new Paging();
        $resultsPerPage = $pg->getResultsPerPage();
        $numberOfPages = $pg->getNumberOfPages("korisnici")-1;

        $page = 1;
        //set current page
        if (isset($_POST['page'])) {
            $page = $_POST['page'];
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

            array_push($userArray, array("firstname" => $firstName, "lastname" => $lastName, "username" => $username, "email" => $email,
                "registerdate" => $registerDate, "numberofattemps" => $numberOfAttemps, "status" => $status));
        }
        //return json
        echo json_encode($userArray);
    } 
    else {
        $location = "index.php";
        header("Location: $location");
    }
?>
