<?php
    require ('libraries/Smarty/libs/Smarty.class.php');
    include ('database.class.php');
    include ('session.class.php');
    $tekst = "HOME PAGE";
    Session::createSession();
    if(isset($_SESSION['user'])){
        $array = Session::returnUserData();
        $tekst = $array['username']." ".$array['type']." ".$array['level']." ".$array['$numberIncorrectLogin'];
    }
    
    $smarty = new Smarty();
    $smarty->assign("tekst",$tekst);
    $smarty->display("templates/index.tpl");
?>