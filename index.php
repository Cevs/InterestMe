<?php
    require ('libraries/Smarty/libs/Smarty.class.php');
    include ('database.class.php');
    include ('session.class.php');
    $tekst = "HOME PAGE";
    
    Session::createSession();
    
    //Configurations
    $logoutButtonDisplay = "none";
    $loginButtonDisplay = "inline";
    $signinButtonDisplay = "inline";
    $administrator = "none";
    
    if(isset($_SESSION['user'])){
        $array = Session::returnUserData();
        $tekst = $array['username']." ".$array['type']." ".$array['level']." ".$array['$numberIncorrectLogin'];
        $logoutButtonDisplay = "inline";
        $loginButtonDisplay = "none";
        $signinButtonDisplay = "none";
        
        //administrator
        if (isset($_SESSION['user']) && in_array("administrator", $_SESSION['user'])) {
            $administrator = "inline";
        }
        
    }
    
    $smarty = new Smarty();
    $smarty->assign("administrator",$administrator);
    $smarty->assign("loginDisplay",$loginButtonDisplay);
    $smarty->assign("signinDisplay",$signinButtonDisplay);
    $smarty->assign("logoutDisplay",$logoutButtonDisplay);
    $smarty->assign("tekst",$tekst);
    $smarty->display("templates/index.tpl");
?>