<?php

require ('libraries/Smarty/libs/Smarty.class.php');
include ('database.class.php');
include ('session.class.php');
include ("virtual_time.class.php");
require('libraries/FPDF/fpdf.php');

Session::createSession();

//Configurations
$logoutButtonDisplay = "none";
$loginButtonDisplay = "inline";
$signinButtonDisplay = "inline";
$administrator = "none";

if (isset($_SESSION['user']) && in_array("administrator", $_SESSION['user'])) {

    $smarty = new Smarty();

    if (isset($_FILES["file"]["type"])) {
        $extensions = array("png", "jpeg", "jpg");
        $nameArray = explode(".", $_FILES["file"]["name"]);
        //get the last item in array - file extension
        $file_extensions = end($nameArray);

        if ((($_FILES["file"]["type"] == "image/png") || ($_FILES["file"]["type"] == "image/jpeg") || ($_FILES["file"]["type"] == "image/jpg")) && ($_FILES["file"]["size"] < 2097152) && in_array($file_extensions, $extensions)) {

            if ($_FILES["file"]["error"] > 0) {
                $smarty->assign("error", $_FILES['file']['error']);
                $smarty->assign("administrator", $administrator);
                $smarty->assign("loginDisplay", $loginButtonDisplay);
                $smarty->assign("signinDisplay", $signinButtonDisplay);
                $smarty->assign("logoutDisplay", $logoutButtonDisplay);
                $smarty->display("templates/coupon.tpl");
            } else {

                $targetPath = "";
                if (file_exists("coupons/images/" . $_FILES['file']['name'])) {
                    $targetPath = "coupons/images/" . $_FILES['file']['name'];
                } else {
                    $sourcePath = $_FILES['file']['tmp_name']; // Storing source path of the file in a variable
                    $targetPath = "coupons/images/" . $_FILES['file']['name']; // Target path where file is to be stored
                    move_uploaded_file($sourcePath, $targetPath); // saving picture on server so it can be used for creating pdf
                }

                $title = $_POST['coupon-name'];
                $description = $_POST['coupon-description'];
                $imgPath = $targetPath;
                $filename = $title . ".pdf";
                $dirPath = "coupons/$filename";

                generateSavePDF($title, $description, $imgPath, $dirPath);
                saveInDb($title, $imgPath, $dirPath);

                $location = "coupon-management.php";
                header("Location: $location");
            }
        } else {
            $smarty->assign("error", "invalid filesize or type");

        }
    }


    ///Pressed delete button on table
    if (isset($_GET['id']) && !empty($_GET['id']) && isset($_GET['action']) && $_GET['action'] === 'delete') {
        $id = $_GET['id'];
        deleteCoupon($id);
    }


    $smarty->assign("error", "");
    $smarty->assign("administrator", $administrator);
    $smarty->assign("loginDisplay", $loginButtonDisplay);
    $smarty->assign("signinDisplay", $signinButtonDisplay);
    $smarty->assign("logoutDisplay", $logoutButtonDisplay);
    $smarty->display("templates/coupon.tpl");
}

function generateSavePDF($title, $description, $imgPath, $dirPath) {
    $pdf = new FPDF();

    //set font
    $pdf->SetFont('Arial', 'B', 12);
    $pdf->SetTextColor(50, 60, 100);

    //set up a page
    $pdf->AddPage('P');
    $pdf->SetDisplayMode('real', 'default');
    //SetTitle
    $pdf->SetFontSize(22);
    $pdf->SetXY(10, 200);
    $pdf->Write(22, $title, "");

    //Set description
    $pdf->SetXY(10, 20);
    $pdf->SetFontSize(16);
    $pdf->Write(22, $description, "");

    //Set image
    $pdf->Image($imgPath, 10, 50, 100);

    //save PDF
    $pdf->Output($dirPath, 'F');
}

function saveInDB($title, $imgPath, $pdfPath) {
    $db = new Database();
    $db->openConnectionDB();
    $sql = "INSERT INTO kuponi_clanstva (naziv, pdf, slika) VALUES ('" . $title . "', '" . $pdfPath . "', '" . $imgPath . "')";
    $db->insertDB($sql);
    $db->closeConnectionDB();
}

function deleteCoupon($id) {
    $location = "coupon-management.php";
    $db = new Database();
    $db->openConnectionDB();

    $sql = "DELETE FROM kuponi_clanstva WHERE  id_kupon_clanstva = $id";
    $db->updateDB($sql, $location);
    $db->closeConnectionDB();
}




?>