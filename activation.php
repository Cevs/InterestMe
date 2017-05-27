<?php
    require ("database.class.php");
    if(isset($_GET["activationcode"]) && !empty($_GET["activationcode"])){
        $idUser = -1;
        $expirationDate = "";
        $code = $_GET["activationcode"];
        $db = new DataBase();
        $db->openConnectionDB();
        $sql = "SELECT id_korisnik, vrijeme_isteka_aktivacijskog_koda FROM korisnici WHERE aktivacijski_kod = '".$code."'";
        $result =  $db->selectDB($sql);
   
        
        if(mysqli_num_rows($result) == 1){
           while($row = mysqli_fetch_array($result)){
               $idUser = $row["id_korisnik"];
               $expirationDate = $row['vrijeme_isteka_aktivacijskog_koda'];
           }
        }
        
        $timeNow = date('Y-m-d H:i:s');
        
        if($timeNow <= $expirationDate ){
            $sql = "UPDATE korisnici SET status_korisnickog_racuna = 'AKTRIVIRAN' WHERE id_korisnik = $idUser";
            $script = "login.php";
            $db->updateDB($sql, $script);
        }
        else{
            $location = "register.php";
            header("Location: $location");
        }
        
        $db->closeConnectionDB();
    }
    else{
        $location = "register.php";
        header("Location: $location");
    }
    

?>