<?php

class DataBase 
{
    
    const server = "localhost";
    const user = "root";
    const password = "";
    const database = "webdip";
    
    private $connection = null;
    private $error = '';
    
    function openConnectionDB(){
        $this->connection = mysqli_connect(self::server, self::user, self::password, self::database);
        if($this->connection->connect_errno){
            echo "Unsuccessful connection to the database: ".$this->connection->connect_errno.", ".$this->connection->connect_error;
            $this->error  = $this->connection->connect_error;
        }
        $this->connection->set_charset("utf8");
        if($this->connection->connect_errno){
            echo "Failed to set character for database".$this->connection->connect_errno . ", ". $this->connection->connect_error;
            $this->error = $this->connection->connect_error;
        }
       
        return $this->connection;
    }
    
    function selectDB($sql){
        $result = $this->connection->query($sql);
        if ($this->connection->connect_errno) {
            echo "Inquiry Error: {$sql} - " . $this->connection->connect_errno . ", " .
            $this->connection->connect_error;
            $this->error = $this->connection->connect_error;
        }
   
        return $result;
    }

    function updateDB($sql, $script = '') {
        $result = $this->connection->query($sql);
        if ($this->connection->connect_errno) {
            echo "Inquiry Error: {$sql} - " . $this->connection->connect_errno . ", " .
            $this->connection->connect_error;
            $this->error = $this->connection->connect_error;
        } else {
            if ($script != '') {
                header("Location: $script");
            }
        }

        return $result;
    }
    
    function insertDB($sql){
        $this->openConnectionDB();
        $query = mysqli_query($this->connection,$sql);
        $last_id = mysqli_insert_id($this->connection);    
        if($query){
            return $last_id;
        }
        else{
            return -1;
        }
        
        $this->closeConnectionDB();
    }
    function closeConnectionDB(){
        $this->connection->close();
   
    }
    
    function errorDB(){
        if($this->error != ''){
            return true;
        }
        else{
            return false;
        }
    }
}
