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


    $allowedImageExtensions = array("png", "jpeg", "jpg");
    $allowedVideoExtensions = array("webm", "mp4", "ogv");

    if (isset($_FILES["file"]["type"])) {

        $imageNameArray = explode(".", $_FILES["file"]["name"]);
        //get the last item in array - file extension
        $image_extensions = end($imageNameArray);

        if ((($_FILES["file"]["type"] == "image/png") || ($_FILES["file"]["type"] == "image/jpeg") || ($_FILES["file"]["type"] == "image/jpg")) && ($_FILES["file"]["size"] < 2097152) && in_array($image_extensions, $allowedImageExtensions)) {
            if ($_FILES["file"]["error"] > 0) {
                $smarty->assign("image_error", $_FILES['file']['error']);
            } else {
                $targetImagePath = "";
                if (file_exists("coupons/images/" . $_FILES['file']['name'])) {
                    $targetImagePath = "coupons/images/" . $_FILES['file']['name'];
                } else {
                    $sourcePath = $_FILES['file']['tmp_name']; // Storing source path of the file in a variable
                    $targetImagePath = "coupons/images/" . $_FILES['file']['name']; // Target path where file is to be stored
                    move_uploaded_file($sourcePath, $targetImagePath); // saving picture on server so it can be used for creating pdf
                }

                $title = $_POST['coupon-name'];
                $description = $_POST['coupon-description'];
                $imgPath = $targetImagePath;
                $filename = $title . ".pdf";
                $pdfPath = "coupons/$filename";


                if (isset($_FILES["video"]["type"])) {
                    $videoNameArray = explode(".", $_FILES["video"]["name"]);
                    //get the last item in array - file extension
                    $video_extensions = end($videoNameArray);
                    if ((($_FILES["video"]["type"] == "video/webm") || ($_FILES["video"]["type"] == "video/mp4") || ($_FILES["video"]["type"] == "video/ogv")) && ($_FILES["video"]["size"] < 2097152) && in_array($video_extensions, $allowedVideoExtensions)) {
                        if ($_FILES["video"]["error"] > 0) {
                            $smarty->assign("video_error", $_FILES['video']['error']);
                        } else {
                            $targetVideoPath = "";
                            if (file_exists("coupons/videos/" . $_FILES['video']['name'])) {
                                $targetVideoPath = "coupons/videos/" . $_FILES['video']['name'];
                            } else {
                                $sourcePath = $_FILES['video']['tmp_name']; // Storing source path of the file in a variable
                                $targetVideoPath = "coupons/videos/" . $_FILES['video']['name']; // Target path where file is to be stored
                                move_uploaded_file($sourcePath, $targetVideoPath); // saving picture on server so it can be used for creating pdf
                            }
                        }
                    }
                }

                $videoPath = $targetVideoPath;

                generateSavePDF($title, $description, $imgPath, $pdfPath);
                saveInDb($title, $imgPath, $pdfPath, $videoPath);

                $location = "coupon-management.php";
                header("Location: $location");
            }
        } else {
            $smarty->assign("image_error", "invalid filesize or type");
        }
    }


    ///Pressed delete button on table
    if (isset($_GET['id']) && !empty($_GET['id']) && isset($_GET['name']) && !empty($_GET['name']) && isset($_GET['action']) && $_GET['action'] === 'delete') {
        $id = $_GET['id'];
        $name = $_GET['name'];
        deleteCoupon($id, $name);
    }


    $smarty->assign("video_error", "");
    $smarty->assign("image_error", "");
    $smarty->assign("administrator", $administrator);
    $smarty->assign("loginDisplay", $loginButtonDisplay);
    $smarty->assign("signinDisplay", $signinButtonDisplay);
    $smarty->assign("logoutDisplay", $logoutButtonDisplay);
    $smarty->display("templates/coupon.tpl");
}

function generateSavePDF($title, $description, $imgPath, $pdfPath) {
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
    $pdf->Output($pdfPath, 'F');
}

function saveInDB($title, $imgPath, $pdfPath, $videoPath) {
    $db = new Database();
    $db->openConnectionDB();
    $sql = "";
    if ($videoPath != "") {
        $sql = "INSERT INTO kuponi_clanstva (naziv, pdf, slika, video) VALUES ('" . $title . "', '" . $pdfPath . "', '" . $imgPath . "', '" . $videoPath . "')";
    } else {
        $sql = "INSERT INTO kuponi_clanstva (naziv, pdf, slika) VALUES ('" . $title . "', '" . $pdfPath . "', '" . $imgPath . "')";
    }
    $db->insertDB($sql);
    $db->closeConnectionDB();
}

function deleteCoupon($id, $name) {
    $location = "coupon-management.php";
    $db = new Database();
    $db->openConnectionDB();

    $sql = "DELETE FROM kuponi_clanstva WHERE  id_kupon_clanstva = $id";
    $insert = "INSERT INTO proba2 (json) VALUES ('" . $name . "')";
    $db->insertDB($insert);
    $name = trim($name);
    $filePath = "coupons/" . $name . ".pdf";

    //check if file exist and delete it
    if (file_exists($filePath)) {
        unlink($filePath);
    }


 
    $db->updateDB($sql, $location);
    $db->closeConnectionDB();
}

?>