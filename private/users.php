<?php

    include ('../libraries/Smarty/libs/Smarty.class.php');
    include ("../database.class.php");
    include ("../paging.class.php");

  
    
    $pg = new Paging();
    $resultsPerPage = $pg->getResultsPerPage();
    $numberOfPages = $pg->getNumberOfPages("korisnici");
    
    $smarty = new Smarty();
    $smarty->assign("paging",$numberOfPages);
    $smarty->display("../templates/users.tpl");
    
  
?>