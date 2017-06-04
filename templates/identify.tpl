<!DOCTYPE html>
<html lang="hr">
    <head >
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
                                <li class="nav-list-item"><a href="identify.php" class="active" >Identify</a></li>

                            </ul>
                            <div class="nav-button-wrapper">
                                <button type="button" class="button-login-mobile" onclick="window.parent.location.href = 'login.php'">Log In</button>
                                <button type="button" class="button-signin-mobile" onclick="window.parent.location.href = 'register.php'" >Sign In</button>
                            </div>
                        </div>
                    </div>
                </nav>
            </div>
        </header>

        <div id="cont">
                <div class ="notification">
                    <form   method="post" action="identify.php" novalidate="novalidate">
                        <h1>{$title}</h1>
                        <hr>
                        <p class="text-notification">{$message}</p><br>

                        <label for="password-reset-email">Email: </label>
                        <input type="text" id="password-reset-email" name="password-reset-email" placeholder="you@example.org" maxlength="35" size="25">
                        <input type="submit" name ="submit" value ="Reset" style="width: 10em;">


                    </form>

                </div>
        </div>

        <footer>
            <div id="footer-identifiy" class="footer">
                <a class="about-author" href="#">&copy; 2017. A. Martinčević</a>
            </div> 
        </footer>
    </body>

</html>