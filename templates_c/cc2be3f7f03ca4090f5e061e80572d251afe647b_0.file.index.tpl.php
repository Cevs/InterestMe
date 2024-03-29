<?php
/* Smarty version 3.1.31, created on 2017-05-24 18:23:17
  from "C:\xampp\htdocs\InterestMe\templates\index.tpl" */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.31',
  'unifunc' => 'content_5925b375ad95d0_55553055',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'cc2be3f7f03ca4090f5e061e80572d251afe647b' => 
    array (
      0 => 'C:\\xampp\\htdocs\\InterestMe\\templates\\index.tpl',
      1 => 1495635726,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_5925b375ad95d0_55553055 (Smarty_Internal_Template $_smarty_tpl) {
?>
<!DOCTYPE html>
<html>
    <head>
        <title>InterestMe</title>
        <link rel="stylesheet" type="text/css" href="css/main.css">
        <link href="https://fonts.googleapis.com/css?family=Kaushan+Script" rel="stylesheet">
        <!-- Importing jquery files -->
        <?php echo '<script'; ?>
 src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"><?php echo '</script'; ?>
>
        <?php echo '<script'; ?>
 src="js/index_jquery.js" type="text/javascript"><?php echo '</script'; ?>
> 
        <!-- Importing jquery files -->
    </head>

    <body>
        <header>
            <div class="nav-title-container" >
                <button id="expand-collpase-button">
                        <img id="expand-collapse-picture"  src="images/collapse.png" alt="button for collapsing or expending navigation view" >
                </button>
                
                <h1 class="nav-title">InterestMe</h1>
            </div>

            <nav>
                <div class="nav-container">
                    <div class="nav-links">
                        <ul id="nav-list-items">
                            <li class="nav-list-item"><a  href="index.php" class="active" >Home</a></li>
                            <li class="nav-list-item"><a  href="index.php" class="inactive" >Section1</a></li>
                            <li class="nav-list-item"><a  href="index.php" class="inactive" >Section2</a></li>
                            <li class="nav-list-item"><a  href="index.php" class="inactive" >Section3</a></li>
                       
                        </ul>
                    </div>
                    <div class="nav-button-wrapper">
                        <button type="button" class="button-login" >Log In</button>
                        <button type="button" class="button-singin" onclick="window.parent.location.href='register.php'" >Sing In</button>
                    </div>
                </div>

            </nav>
        </header>

        <p>Home</p>

        <footer>
            <div class="about-author">
                <a href="#">&copy; 2017. Alen Martinčević</a>
            </div> 
        </footer>
    </body>

</html><?php }
}
