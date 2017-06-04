<?php

    require ('libraries/Smarty/libs/Smarty.class.php');
    include ('database.class.php');
    include ('session.class.php');
    include ("virtual_time.class.php");

    //Return session
    //If SESSSION not empty, delete session
    $user = Session::returnUser();
    if (!empty($user)) {
        Session::deleteSession();
    }


    $smarty = new Smarty();

    $write = "";
    $code = "";
    $usernameInput = "";
    $passwordInput = "";
    $twosteppassword = "";
    $display = "none";
    $height = ''; //css height
    //if user want to login
    if (isset($_POST['login'])) {
        //check if username and password are sent and not empy
        if (isset($_POST['username']) && isset($_POST['password']) && !empty($_POST['username']) && !empty($_POST['password'])) {
            $db = new DataBase();
            $db->openConnectionDB();
            $username = $_POST['username'];
            $password = getPassword($_POST['password']);
            $sql = "SELECT *FROM korisnici WHERE korisnicko_ime = '" . $username . "' AND status_korisnickog_racuna = 'AKTIVIRAN'";
            $result = $db->selectDB($sql);

            //check if user exist
            if (mysqli_num_rows($result) == 1) {
                $row = mysqli_fetch_array($result);
                $idUser = $row['id_korisnik'];
                $email = $row['email'];
                $numberOfAttemps = $row['neuspjesne_prijave'];
                $twoStepLogin = $row['dvorazinska_prijava'];
                $verificationCode = getVerificationCode($idUser);
                $fkTypeOfUser = $row['vrsta_korisnika_id'];
                $locked = $row['zakljucan_pristup'];

                //get username and password
                $sql = "SELECT *FROM korisnici WHERE korisnicko_ime = '" . $username . "' AND kriptirana_lozinka = '" . $password . "'";
                $resultLogin = $db->selectDB($sql);

                //verification of password and check if user have rights to login
                if ((mysqli_num_rows($resultLogin) == 1) && ($numberOfAttemps < 3) && ($locked != 'ZAKLJUCAN')) {
                    
                    if(isset($_POST['checkbox-rememberme'])){
                        createCookie();
                    }
                    else{
                        deleteCookie();
                    }
                    //Set the number of logging attempts to 0
                    $sqlUpdate = "UPDATE korisnici SET neuspjesne_prijave = 0 WHERE id_korisnik = $idUser";
                    $db->updateDB($sqlUpdate);

                    //if user dont want two step verification/login
                    if ($twoStepLogin == 0) {
                        createSession($username, $numberOfAttemps, $fkTypeOfUser);
                        redirect();
                    }
                    //Two step verification is required
                    else {
                        $height = '490px';
                        $usernameInput = $_POST['username'];
                        $passwordInput = $_POST['password'];
                        if (isset($_POST['verification']) && !empty($_POST['verification'])) {
                            $code = $_POST['verification'];
                            $expired = checkIfExpired($code);
                            if (($code === $verificationCode) && !($expired)) {
                                createSession($username, $numberOfAttemps, $fkTypeOfUser);
                                redirect();
                            } else {
                                $write = "Verification code expired or not valid";
                            }
                            $twoStepLogin = 0;
                            $verificationCode = '';
                        }
                        //User didn't sent verification code
                        //Check if code is generate and if it is not expired
                        else {
                            
                            $virtual = new VirtualTime();
                            $generatedCode = checkIfGenerated($idUser);
                            $display = "inline"; //set visibility of input on form
                            //code doesn't exist. Generate new and send it to user
                            if ($generatedCode === "") {
                                $uniqueCode = generateVerificationCode();
                                while (checkIfExist($uniqueCode)) {
                                    $uniqueCode = generateVerificationCode();
                                }

                                sendVerificationCode($email, $uniqueCode);
                                $virtualTime = $virtual->getVirtualTime();
                                $expirationDate = date("Y-m-d H:i:s", strtotime($virtualTime."+ 5 minutes"));
                             

                                $sqlUpdate = "INSERT INTO kodovi_prijave (korisnik_id, jedinstveni_kod, vrijedi_do) VALUES (" . $idUser . ", '" . $uniqueCode . "', '" . $expirationDate . "')";
                                $db->updateDB($sqlUpdate);
                            }
                            //code exist
                            else {
                                $expired = checkIfExpired($generatedCode);
                                if ($expired) {
                                    $write = "Code expired. New has been sent.";
                                    $uniqueCode = generateVerificationCode();
                                    while (checkIfExist($uniqueCode)) {
                                        $uniqueCode = generateVerificationCode();
                                    }

                                    sendVerificationCode($email, $uniqueCode);
                                    $virtualTime = $virtual->getVirtualTime();
                                    $expirationDate = date("Y-m-d H:i:s", strtotime($virtualTime."+ 5 minutes"));
                                    $sqlUpdate = "INSERT INTO kodovi_prijave (korisnik_id, jedinstveni_kod, vrijedi_do) VALUES (" . $idUser . ", '" . $uniqueCode . "', '" . $expirationDate . "')";
                                    $db->updateDB($sqlUpdate);
                                } else {
                                    $write = "You must enter verification code";
                                }
                            }
                        }
                    }
                }
                //failed to login
                else {
                    if ($numberOfAttemps >= 3 || $locked == 'ZAKLJUCAN') {
                        $write = "Registration is forbidden because of too many unsuccessful attempts to login!";
                        $uniqueCode = '';
                    } else {
                        $write = "Wrong password";
                        $uniqueCode = '';
                        $numberOfAttemps = $numberOfAttemps + 1;
                        $sqlUpdate = "UPDATE korisnici SET neuspjesne_prijave = $numberOfAttemps WHERE id_korisnik = $idUser";
                        $db->updateDB($sqlUpdate);


                        if ($numberOfAttemps >= 3) {
                            $sqlUpdate = "UPDATE korisnici SET zakljucan_pristup = 'ZAKLJUCAN' WHERE id_korisnik = $idUser";
                            $db->updateDB($sqlUpdate);
                        }
                    }
                }
            }
            //User doesn't exists or account is not activated
            else {
                $write = "User doesn't exists or account is not activated";
            }

            $db->closeConnectionDB();
        }
        //input is empty
        else {
            if (empty($_POST['password']) && empty($_POST['username'])) {
                $write = "You need to enter username and password";
            } else if (empty($_POST['password'])) {
                $write = "You need to enter password";
            } else {
                $write = "You need to enter username";
            }
        }
    }
    
    if (isset($_COOKIE["user"])) {
        $usernameInput = $_COOKIE["user"];
    }

    $smarty->assign("display", $display);
    $smarty->assign("message", $write);
    $smarty->assign("height", $height);
    $smarty->assign("username", $usernameInput);
    $smarty->assign("password", $passwordInput);
    $smarty->display("templates/login.tpl");

    function getPassword($password) {
        $salt = "5aPn3v*z4!1bN<x4i&3";
        $hash = hash('sha256', $password . $salt);
        return $hash;
    }

    function createSession($username, $numberOfAttemps, $fkTypeOfUser) {
        $db = new DataBase();
        $db->openConnectionDB();

        $sql = "SELECT *FROM vrste_korisnika WHERE id_vrsta = $fkTypeOfUser";
        $result = $db->selectDB($sql);
        $row = mysqli_fetch_array($result);
        $typeOfUser = $row['vrsta'];
        $level = $row['razina'];
        Session::createUser($username, $typeOfUser, $level, $numberOfAttemps);
        $db->closeConnectionDB();
    }

    function getVerificationCode($idUser) {
        $db = new Database();
        $db->openConnectionDB();
        $sql = "SELECT *FROM kodovi_prijave WHERE korisnik_id = $idUser";
        $result = $db->selectDB($sql);
        $row = mysqli_fetch_array($result);
        $uniqueCode = $row['jedinstveni_kod'];
        $db->closeConnectionDB();

        return $uniqueCode;
    }

    function checkIfExist($uniqueCode) {
        $exist = false;
        $db = new DataBase();
        $db->openConnectionDB();
        $sql = "SELECT *FROM kodovi_prijave WHERE jedinstveni_kod = '" . $uniqueCode . "'";
        $result = $db->selectDB($sql);
        if (mysqli_num_rows($result) != 0) {
            $exist = true;
        }
        $db->closeConnectionDB();
        return $exist;
    }

    function checkIfExpired($code) {
        $expired = false;
        $db = new DataBase();
        $db->openConnectionDB();
        $sql = "SELECT *FROM kodovi_prijave WHERE jedinstveni_kod = '" . $code . "'";
        $result = $db->selectDB($sql);
        $row = mysqli_fetch_array($result);
        $expirationDateTime = $row['vrijedi_do'];

        $timeNow = date("Y-m-d H:i:s");

        //if expired, set expire to true and delete it from database
        if ($timeNow > $expirationDateTime) {
            $sql = "DELETE FROM kodovi_prijave WHERE jedinstveni_kod = '" . $code . "'";
            $db->updateDB($sql);
            $expired = true;
        }
        $db->closeConnectionDB();
        return ($expired);
    }

    function generateVerificationCode() {
        $code = mt_rand(100000, 999999);
        return ($code);
    }

    function checkIfGenerated($idUser) {
        $code = "";
        $db = new Database();
        $db->openConnectionDB();
        $sql = "SELECT *FROM kodovi_prijave WHERE korisnik_id = $idUser";
        $result = $db->selectDB($sql);
        if (mysqli_num_rows($result) != 0) {
            $row = mysqli_fetch_array($result);
            $code = $row['jedinstveni_kod'];
        }
        $db->closeConnectionDB();
        return ($code);
    }

    function sendVerificationCode($email, $code) {
        $to = $email;
        $subject = "Unique verification code for login";
        $body = "Uqnique code: $code";
        $from = "From: alemartin@foi.hr";

        mail($to, $subject, $body, $from);
    }

    function redirect() {

        $adresa = "index.php";
        header("Location: $adresa");
    }

    //Saving the username value in cookie
    function createCookie() {
        if (!isset($_COOKIE["user"])) {
            setcookie("user", $_POST["username"], time() + 259200, "/");
        }
    }
    
    function deleteCookie(){
        if (isset($_COOKIE["user"])) {
            setcookie("user", $_POST["username"], time() + -3600, "/");
        }
    }
?>