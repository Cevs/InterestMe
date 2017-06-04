<!DOCTYPE html>
<html>
    <head lang="hr">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>InterestMe</title>
        <link rel="stylesheet" type="text/css" href="css/main.css">
        <link href="https://fonts.googleapis.com/css?family=Kaushan+Script" rel="stylesheet">
        <!-- Importing jquery files -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="js/jquery.js" type="text/javascript"></script> 
        <!-- Importing jquery files -->
    </head>

    <body>
         <header>
            <div id="header-container">
                <div class="nav-title-container">
                    <button id="expand-collpase-button">
                        <img id="expand-collapse-picture"  src="images/collapse.png" alt="button for collapsing or expending navigation view">
                    </button>

                    <h1 class="nav-title">InterestMe</h1>
                    <div class="nav-button-wrapper">
                        <button type="button" class="button-login" onclick="window.parent.location.href = 'login.php'">Log In</button>
                        <button type="button" class="button-signin" onclick="window.parent.location.href = 'register.php'" >Sign In</button>
                    </div>

                </div>
                <nav>
                    <div class="nav-container">
                        <div class="nav-links">
                            <ul id="nav-list-items">
                                <li class="nav-list-item"><a href="index.php" class="inactive" >Home</a></li>
                                <li class="nav-list-item"><a href="index.php" class="inactive" >Section1</a></li>
                                <li class="nav-list-item"><a href="index.php" class="inactive" >Section2</a></li>
                                <li class="nav-list-item"><a href="index.php" class="inactive" >Section3</a></li>
                                <li class="nav-list-item"><a href="login.php" class="active" >Login</a></li>

                            </ul>
                            <div class="nav-button-wrapper">
                                <button type="button" class="button-login-mobile" onclick="window.parent.location.href = 'login.php'">Log In</button>
                                <button type="button" class="button-signin-mobile" onclick="window.parent.location.href = 'register.php'" >Sing In</button>
                            </div>
                        </div>
                    </div>
                </nav>
            </div>
        </header>

        <div id="cont">
                <div class ="notification">
                    <h1>{$title}</h1>
                    <hr>
                    <p class="text-notification">{$message}</p><br>
                    <h1><a href="{$link}">{$link_message}</a></h1>
                </div>
        </div>

        <footer>
            <div id="footer-activation" class="footer">
                <a class="about-author" href="#">&copy; 2017. A. Martinčević</a>
            </div> 
        </footer>
    </body>

</html>