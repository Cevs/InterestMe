<?php

    include ('libraries/Smarty/libs/Smarty.class.php');
    include ("database.class.php");
    include("session.class.php");
    include ("paging.class.php");

    Session::createSession();

    //check if user is administrator
    if (isset($_SESSION['user']) && in_array("administrator", $_SESSION['user'])) {
        $db = new DataBase();
        $db->openConnectionDB();

        if (isset($_POST['chk_unlock']) && !empty($_POST['chk_unlock'])) {
            foreach ($_POST['chk_unlock'] as $i => $value) {
                $username = $value;
                $sqlUpdate = "UPDATE korisnici SET zakljucan_pristup = 0, neuspjesne_prijave = 0 WHERE korisnicko_ime  = '" . $username . "'";
                $db->updateDB($sqlUpdate);
            }
        }

        if (isset($_POST['chk_lock']) && !empty($_POST['chk_lock'])) {
            foreach ($_POST['chk_lock'] as $i => $value) {
                $username = $value;
                $sqlUpdate = "UPDATE korisnici SET zakljucan_pristup = 1 WHERE korisnicko_ime  = '" . $username . "'";
                $db->updateDB($sqlUpdate);
            }
        }

        $pg = new Paging();
        $resultsPerPage = $pg->getResultsPerPage();
        $numberOfPages = $pg->getNumberOfPages("korisnici");


        $db->closeConnectionDB();

        $smarty = new Smarty();
        $smarty->assign("paging", $numberOfPages);
        $smarty->display('templates/user_management.tpl');
    } else {
        $location = "index.php";
        header("Location: $location");
    }
?>