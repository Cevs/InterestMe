<?php

require_once  ("database.class.php");

class Paging {
    
    private $results_per_page;
    private $db;
    
    function __construct() {
        $this->db = new DataBase();
        $this->db->openConnectionDB();
    }
  
    function getNumberOfPages($tableName){
        
        $sql = "SELECT *FROM $tableName";
        $result = $this->db->selectDB($sql);
        $number_of_results = mysqli_num_rows($result);
        
        $number_of_pages = ceil($number_of_results /$this->results_per_page);
 
        return $number_of_pages;
            
    }
    
   
    //TO DO: This function needs to have sql query to db to see what are configurations paremeters for pagging
    function getResultsPerPage(){
        $this->results_per_page = 10;
        return $this->results_per_page;
    }
    
    function __destruct() {
        $this->db->closeConnectionDB();
    }
    
}
?>