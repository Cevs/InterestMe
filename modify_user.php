<?php

require ('libraries/Smarty/libs/Smarty.class.php');
include ('database.class.php');
include ('session.class.php');
include ("virtual_time.class.php");



Session::createSession();


//Configurations
$logoutButtonDisplay = "none";
$loginButtonDisplay = "inline";
$signinButtonDisplay = "inline";
$administrator = "none";


$userData = [];
$userTypes = [];

//Check for administrator
if (isset($_SESSION['user']) && in_array("administrator", $_SESSION['user'])) {
    $logoutButtonDisplay = "inline";
    $loginButtonDisplay = "none";
    $signinButtonDisplay = "none";
    $administrator = "inline";
    $action = "";
    $userTypes = getAllTypes();

    //Pressed update button on table
    if (isset($_GET['username']) && !empty($_GET['username']) && isset($_GET['action'])&& $_GET['action']==='update') {

        $username = $_GET['username'];
        $userData = getUserData($username);
        $action = "update";
    }
    ///Pressed delete button on table
    else if (isset($_GET['username']) && !empty($_GET['username'])&&isset($_GET['action'])&& $_GET['action']==='delete'){
            $username = $_GET['username'];
            deleteUser($username);
    }
    
    //Pressed button for inserting new user
     else if (isset($_GET['action'])&& $_GET['action']==='insert'){
        $action = "insert";  
     }
           
   

    //Form submitted
    if (isset($_POST['submit'])) {
        $id = $_POST['user-id'];
        $userTypeId = $_POST['user-tpye'];
        $username = $_POST['user-username'];
        $firstname = $_POST['user-firstname'];
        $lastName = $_POST['user-lastname'];
        $email = $_POST['user-email'];
        $telephoneNumber = $_POST['user-telephone-number'];
        $password = $_POST['user-password'];
        $registrationDate = $_POST['user-registration-date'];
        $twoStepLogin = isset($_POST['user-two-step-login']) ? 1 : 0;
        $city = $_POST['user-city'];
        $country = $_POST['user-country'];
        $points = $_POST['user-points'];
        $access = $_POST['user-access'];
        $attempts = $_POST['user-attempts'];
        $status = $_POST['user-account-status'];
        $expirationTime = $_POST['user-code-time-expiration'];
        
        //Form submitted for updating
        if($_POST['action']==='update'){
            updateUser($id, $userTypeId, $username, $firstname, $lastName, $email, $telephoneNumber, $password, $registrationDate, $twoStepLogin, $city, $country, $points, $access
                , $attempts, $status, $expirationTime);
        }
          //Form submitted for inserting
        if($_POST['action']==='insert'){
            insertUser($userTypeId, $username, $firstname, $lastName, $email, $telephoneNumber, $password, $registrationDate, $twoStepLogin, $city, $country, $points, $access
                , $attempts, $status, $expirationTime);
        }
        
        
    } 
    //Set form data of selected user
    else if (isset($_GET['action']) && $_GET['action'] === 'update'){
        $smarty = new Smarty();

        foreach ($userData as $name => $value) {
            $smarty->assign($name, $value);
        }

    }
    //set form data to empty
    else if(isset($_GET['action']) && $_GET['action'] === 'insert'){
        
        $smarty = new Smarty();
        //set fields of form to empty
        $smarty->assign("id","");
        $smarty->assign("type","");
        $smarty->assign("username","");
        $smarty->assign("email","");
        $smarty->assign("firstname","");
        $smarty->assign("lastname","");
        $smarty->assign("telephone_number","");
        $smarty->assign("password","");
        $smarty->assign("registration_date", getDateTime());
        $smarty->assign("two_step_login","");
        $smarty->assign("city","");
        $smarty->assign("country","");
        $smarty->assign("points","");
        $smarty->assign("access","");
        $smarty->assign("attempts","");
        $smarty->assign("account_status","");
        $smarty->assign("expiration_time","");
      
    }
    
    //Set common options and display form
    $smarty->assign("action",$action);
    $smarty->assign("user_types", $userTypes);
    $smarty->assign("administrator",$administrator);
    $smarty->assign("loginDisplay", $loginButtonDisplay);
    $smarty->assign("signinDisplay", $signinButtonDisplay);
    $smarty->assign("logoutDisplay", $logoutButtonDisplay);
    $smarty->display("templates/modify_user.tpl");
} else {
    $location = "index.php";
    header("Location: $location");
}

function GetHash($password) {
    $salt = "5aPn3v*z4!1bN<x4i&3";
    $hash = hash('sha256', $password . $salt);

    return($hash);
}



function getUserData($username) {
    $db = new DataBase();
    $db->openConnectionDB();


    $sql = "SELECT *FROM korisnici WHERE korisnicko_ime = '" . $username . "'";
    $result = $db->selectDB($sql);
    $array = [];

    $row = mysqli_fetch_array($result);
    $id = $row['id_korisnik'];
    $type = getUserType($row['vrsta_korisnika_id']);
    $email = $row['email'];
    $firstname = $row['ime'];
    $lastname = $row['prezime'];
    $telephoneNumber = $row['broj_telefona'];
    $password = $row['lozinka'];
    $registrationDate = $row['datum_registriranja'];
    $twoStepLogin = $row['dvorazinska_prijava'];
    $city = $row['grad'];
    $country = $row['drzava'];
    $points = $row['ukupno_ostvareni_bodovi'];
    $access = $row['zakljucan_pristup'];
    $attempts = $row['neuspjesne_prijave'];
    $status = $row['status_korisnickog_racuna'];
    $expirationTime = $row['vrijeme_isteka_aktivacijskog_koda'];
    //vrijeme pocetka koristenja kolacica
    //vrijeme kraja koristenja kolacicca


    $array = array_push_associative($array, "id", $id);
    $array = array_push_associative($array, "type", $type);
    $array = array_push_associative($array, "username", $username);
    $array = array_push_associative($array, "email", $email);
    $array = array_push_associative($array, "firstname", $firstname);
    $array = array_push_associative($array, "lastname", $lastname);
    $array = array_push_associative($array, "telephone_number", $telephoneNumber);
    $array = array_push_associative($array, "password", $password);
    $array = array_push_associative($array, "registration_date", $registrationDate);
    $array = array_push_associative($array, "two_step_login", $twoStepLogin);
    $array = array_push_associative($array, "city", $city);
    $array = array_push_associative($array, "country", $country);
    $array = array_push_associative($array, "points", $points);
    $array = array_push_associative($array, "access", $access);
    $array = array_push_associative($array, "attempts", $attempts);
    $array = array_push_associative($array, "account_status", $status);
    $array = array_push_associative($array, "expiration_time", $expirationTime);
    $db->closeConnectionDB();
    return $array;
}

//return title of user type
function getUserType($userTypeId) {
    $db = new DataBase();
    $db->openConnectionDB();

    $sql = "SELECT *FROM vrste_korisnika WHERE id_vrsta = $userTypeId";
    $result = $db->selectDB($sql);

    $row = mysqli_fetch_array($result);
    $type = $row['vrsta'];

    $db->closeConnectionDB();
    return ($type);
}

function array_push_associative($array, $key, $value) {
    $array[$key] = $value;
    return $array;
}

//Return all user types that exists in db
function getAllTypes() {
    $db = new DataBase();
    $db->openConnectionDB();
    $sql = "SELECT *FROM vrste_korisnika";
    $result = $db->selectDB($sql);
    $typeArray = [];
    while ($row = mysqli_fetch_array($result)) {
        $name = $row['vrsta'];
        $typeId = $row['id_vrsta'];

        $typeArray = array_push_associative($typeArray, $typeId, $name);
    }
    $db->closeConnectionDB();
    return $typeArray;
}

//TO DO: treba dodati azutitanje atributa aktivacijski_kod, pocetak_ koristenja_ kolacica, kraj_koristenja_kolacica. vrijeme_isteka_aktivacijskog_koda
function updateUser($id, $userTypeId, $username, $firstname, $lastName, $email, $telephoneNumber, $password, $registrationDate, $twoStepLogin, $city, $country, $points, $access, $attempts, $status, $expirationTime) {
    $db = new DataBase();
    $db->openConnectionDB();
    $hash = GetHash($password);
    $twoStepLogin = trim($twoStepLogin);

     
    $sql = "UPDATE korisnici SET vrsta_korisnika_id = $userTypeId, korisnicko_ime ='" . $username . "', email = '" . $email . "', ime ='" . $firstname . "', prezime='" . $lastName . "', "
            . "lozinka = '" . $password . "', kriptirana_lozinka ='" . $hash . "', datum_registriranja = '" . $registrationDate . "', grad = '" . $city . "', drzava = '" . $country . "', "
            . "status_korisnickog_racuna = '" . $status . "', broj_telefona = '" . $telephoneNumber . "', dvorazinska_prijava = $twoStepLogin, ukupno_ostvareni_bodovi = $points, "
            . " zakljucan_pristup = $access, neuspjesne_prijave = $attempts, vrijeme_isteka_aktivacijskog_koda = '" . $expirationTime . "' WHERE id_korisnik = $id";

    $db->updateDB($sql, "user_management.php");

    $db->closeConnectionDB();
}

function deleteUser($username) {
    $location = "user_management.php";
    $db = new Database();
    $db->openConnectionDB();
    $sql = "DELETE FROM korisnici WHERE korisnicko_ime = '" . $username . "'";
    $db->updateDB($sql, $location);
    $db->closeConnectionDB();
}


function insertUser($userTypeId, $username, $firstname, $lastname, $email, $telephoneNumber, $password, $registrationDate, $twoStepLogin, $city, $country, $points, $access
                , $attempts, $status, $expirationTime)
{
    
    $hash = GetHash($password);
    
    $db = new DataBase();
    $sql = "INSERT INTO korisnici (vrsta_korisnika_id, korisnicko_ime, email, ime, prezime, lozinka, kriptirana_lozinka, datum_registriranja, grad, drzava, status_korisnickog_racuna,"
            . " broj_telefona, dvorazinska_prijava, ukupno_ostvareni_bodovi, zakljucan_pristup, neuspjesne_prijave, vrijeme_isteka_aktivacijskog_koda) VALUES ("
            . " $userTypeId, '".$username."', '".$email."', '".$firstname."', '".$lastname."', '".$password."', '".$hash."', '".$registrationDate."', '".$city."', '"
            .$country."', '".$status."', '".$telephoneNumber."', '".$twoStepLogin."', $points, $access, $attempts, '".$expirationTime."')";
      
    $db->insertDB($sql);
    
    $location = "user_management.php";
    header("Location: $location");
}

function getDateTime(){
    $virtual = new VirtualTime();
    $virtualTime = $virtual->getVirtualTime();
 
    return $virtualTime;
}
?>

