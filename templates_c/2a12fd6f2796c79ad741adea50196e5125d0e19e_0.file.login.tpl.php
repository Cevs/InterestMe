<?php
/* Smarty version 3.1.31, created on 2017-05-26 18:55:09
  from "C:\xampp\htdocs\InterestMe\templates\login.tpl" */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.31',
  'unifunc' => 'content_59285ded904eb6_37442371',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '2a12fd6f2796c79ad741adea50196e5125d0e19e' => 
    array (
      0 => 'C:\\xampp\\htdocs\\InterestMe\\templates\\login.tpl',
      1 => 1495817709,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_59285ded904eb6_37442371 (Smarty_Internal_Template $_smarty_tpl) {
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



    <body id="body-registration">

        <div id="cont">
            <header>
                <div class="nav-title-container" >
                    <button id="expand-collpase-button">
                        <img id="expand-collapse-picture"  src="images/collapse.png" alt="button for collapsing or expending navigation view">
                    </button>
                    <h1 class="nav-title">InterestMe</h1>
                </div>

                <nav>
                    <div class="nav-container">
                        <div class="nav-links">
                            <ul id="nav-list-items">
                                <li class="nav-list-item"><a href="index.php" class="inactive" >Home</a></li>
                                <li class="nav-list-item"><a href="index.php" class="inactive" >Section1</a></li>
                                <li class="nav-list-item"><a href="index.php" class="inactive" >Section2</a></li>
                                <li class="nav-list-item"><a href="index.php" class="inactive" >Section3</a></li>
                                <li class="nav-list-item"><a href="register.php" class="active" >Register</a></li>

                            </ul>
                        </div>
                        <div class="nav-button-wrapper">
                            <button type="button" class="button-login" onclick="window.parent.location.href = 'login.php'">Log In</button>
                            <button type="button" class="button-singin" onclick="window.parent.location.href = 'register.php'" >Sing In</button>
                        </div>
                    </div>

                </nav>
            </header>

            <section>
                <div id="login-container">
                    <form class="login" method="post">
                        <h1>Login</h1>
                        <hr>
                        <label for="username">Username</label>
                        <input type="text" id="username" name="username" placeholder="username">
                        <label for="password">Password</label>
                        <input type="password" id="password" name="password" placeholder="*******">
                        <div class="input-verification" >
                            <label for="verification">Verification</label>
                            <input type="password" id="verification" name="verification" placeholder="Secret Code">
                        </div>


                        <div class="checkbox-container">
                            <input  id="checkbox-rememberme" name="checkbox-rememberme"  type="checkbox">
                            <label for="checkbox-rememberme">Remember me</label>              
                        </div>
                        <input id="button-submit-login" type="submit" value ="Login">
                        <hr>
                    </form>
                </div>

            </section>



        </div>
        <footer>
            <div id="footer">
                <a class="about-author" href="#">&copy; 2017. A. Martinčević</a>
            </div>
        </footer>

    </body>
</html><?php }
}
