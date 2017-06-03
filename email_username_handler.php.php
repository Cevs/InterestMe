<?php
    include ('database.class.php');
    
    if(isset($_POST['username']) && !empty($_POST['username'])){
        $username = $_POST['username'];
        $db = new DataBase();
        $db->openConnectionDB();

        $sql = "SELECT *FROM korisnici WHERE korisnicko_ime = '".$username."'";
        $result = $db->selectDB($sql);
        
        $numberOfRows = mysqli_num_rows($result);
        
       

        $db->closeConnectionDB();
        echo $numberOfRows;
    
    }
    if(isset($_POST['email']) && !empty($_POST['email'])){
        $email = $_POST['email'];
        $db = new DataBase();
        $db->openConnectionDB();

        $sql = "SELECT *FROM korisnici WHERE email = '".$email."'";
        $result = $db->selectDB($sql);
        
        $numberOfRows = mysqli_num_rows($result);
        
       

        $db->closeConnectionDB();
        echo $numberOfRows;
    
    }
   

?>
