<?php

class Baza 
{
    
    const server = "localhost";
    const korisnik = "root";
    const lozinka = "";
    const baza = "webdip";
    
    private $veza = null;
    private $greska = '';
    
    function otvoriKonekcijuDB(){
        $this->veza = mysqli_connect(self::server, self::korisnik, self::lozinka, self::baza);
        if($this->veza->connect_errno){
            echo "Neuspješno spajanje na bazu: ".$this->veza->connect_errno.", ".$this->veza->connect_error;
            $this->greska = $this->veza->connect_error;
        }
        $this->veza->set_charset("utf8");
        if($this->veza->connect_errno){
            echo "Neuspješno postavljanje znakova za bazu ".$this->veta->connect_errno . ", ". $this->veza->connect_error;
            $this->greska = $this->veza->connect_error;
        }
       
        return $this->veza;
    }
    
    function selectDB($upit){
        $rezultat = $this->veza->query($upit);
        if ($this->veza->connect_errno) {
            echo "Greška kod upita: {$upit} - " . $this->veza->connect_errno . ", " .
            $this->veza->connect_error;
            $this->greska = $this->veza->connect_error;
        }
   
        return $rezultat;
    }

    function updateDB($upit, $skripta = '') {
        $rezultat = $this->veza->query($upit);
        if ($this->veza->connect_errno) {
            echo "Greška kod upita: {$upit} - " . $this->veza->connect_errno . ", " .
            $this->veza->connect_error;
            $this->greska = $this->veza->connect_error;
        } else {
            if ($skripta != '') {
                header("Location: $skripta");
            }
        }

        return $rezultat;
    }
    
    function insertDB($nosql){
        $this->otvoriKonekcijuDB();
        $query = mysqli_query($this->veza,$nosql);
        $last_id = mysqli_insert_id($this->veza);    
        if($query){
   
            return $last_id;
        }
        else{
  
            return -1;
        }
        
        $this->zatvoriKonekcijuDB();
    }
    function zatvoriKonekcijuDB(){
        $this->veza->close();
   
    }
    
    function pogreskaDB(){
        if($this->greska != ''){
            return true;
        }
        else{
            return false;
        }
    }
}
