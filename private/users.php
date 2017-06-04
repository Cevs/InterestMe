<?php

    include ('../libraries/Smarty/libs/Smarty.class.php');
    include ("../database.class.php");
    include ("../paging.class.php");
    include ('../session.class.php');
    Session::createSession();

    if (isset($_SESSION['user']) && in_array("administrator", $_SESSION['user'])) {
       $pg = new Paging();
        $resultsPerPage = $pg->getResultsPerPage();
        $numberOfPages = $pg->getNumberOfPages("korisnici");
        
        $logoutButtonDisplay = "inline";
        $loginButtonDisplay = "none";
        $signinButtonDisplay = "none";

        $smarty = new Smarty();
        $smarty->assign("loginDisplay",$loginButtonDisplay);
        $smarty->assign("signinDisplay",$signinButtonDisplay);
        $smarty->assign("logoutDisplay",$logoutButtonDisplay);
        $smarty->assign("paging",$numberOfPages);
        $smarty->display("../templates/korisnici.tpl"); 
    }
    else{
        $location = "../index.php";
        header("Location: $location");
    }
 
?>