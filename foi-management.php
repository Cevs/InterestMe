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

    $pg = new Paging();
    $resultsPerPage = $pg->getResultsPerPage();
    $numberOfPages = $pg->getNumberOfPages("interesi") -1;

    $db->closeConnectionDB();

    $logoutButtonDisplay = "inline";
    $loginButtonDisplay = "none";
    $signinButtonDisplay = "none";
    $administrator = "inline";  //administrator link to style display inline

    $smarty = new Smarty();
    $smarty->assign("loginDisplay", $loginButtonDisplay);
    $smarty->assign("signinDisplay", $signinButtonDisplay);
    $smarty->assign("logoutDisplay", $logoutButtonDisplay);
    $smarty->assign("administrator", $administrator);
    $smarty->assign("paging", $numberOfPages);
    $smarty->display('templates/foi-management.tpl');
} else {
    $location = "index.php";
    header("Location: $location");
}
?>