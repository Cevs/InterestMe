<?php

class VirtualTime {
    
    function getVirtualTime(){
        $offset = 0;
        
        $xml = new DOMDocument('1.0');
        //Read from file
        if(file_exists('time_shift.xml')){
            $xml->load('time_shift.xml');
            $offset = (int)$xml->getElementsByTagName('hour')->item(0)->nodeValue;
        }
        
        $date = date("Y-m-d H:i:s");
        if($offset < 0 ){
            $virtualTime = strtotime($date." $offset hours");
        }
        else{
            $virtualTime = strtotime($date." +$offset hours");
        }
            
        return (date("Y-m-d H:i:s",$virtualTime));
      
    }  
}
?>
