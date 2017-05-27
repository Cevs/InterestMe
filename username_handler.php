<?php
    include ('baza.class.php');
    
    if(isset($_POST['username']) && !empty($_POST['username'])){
        $username = $_POST['username'];
        $db = new Baza();
        $db->otvoriKonekcijuDB();

        $sql = "SELECT *FROM korisnici WHERE username = '".$username."'";
        $result = $db->selectDB($sql);
        
        $numberOfRows = mysqli_num_rows($result);
        $db->zatvoriKonekcijuDB();
        echo $numberOfRows;

    }   

?>
