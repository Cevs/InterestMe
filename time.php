<?php

    require ('libraries/Smarty/libs/Smarty.class.php');
    include ('database.class.php');
    include ('session.class.php');
       
    Session::createSession();
    
    //check if user is administrator
    if(isset($_SESSION['user']) && in_array("administrator", $_SESSION['user'])){
     
        $value = 0;
        $xml = new DOMDocument('1.0');
        $xml->formatOutput = true;

        //Read from file
        if(file_exists('time_shift.xml')){
            $xml->load('time_shift.xml');
            $value = $xml->getElementsByTagName('hour')->item(0)->nodeValue;
        }


        if(isset($_POST["time-shift"])  && isset($_POST['submit'])){

            //If file exist, override nnode
            if(file_exists('time_shift.xml')){
                $xml->load('time_shift.xml');
                $value = $_POST["time-shift"];

                $xml->getElementsByTagName('hour')->item(0)->nodeValue = $value;

            }
            //else create new file with structure <WebDiP><time><hour>value</hour></time></WebDiP>
            else{
                $root = $xml->createElement("WebDiP");
                $xml->appendChild($root); //parent->appendChild(child) - We must apdate parent with child

                $time = $xml->createElement("time");
                $root->appendChild($time);

                $hour = $xml->createElement("hour",$_POST["time-shift"]);
                $time->appendChild($hour);

            }

            $xml->save("time_shift.xml") or die("Error while creating xml file");

        }



        $smarty = new Smarty();
        $smarty->assign("value",$value);
        $smarty->display("templates/time.tpl");

        }
        else{
            $location = "index.php";
            header("Location: $location");
        }
     
?>