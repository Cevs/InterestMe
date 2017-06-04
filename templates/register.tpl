<!DOCTYPE html>
<html  lang="hr">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>InterestMe</title>
        <link rel="stylesheet" type="text/css" href="css/main.css">
        <link href="https://fonts.googleapis.com/css?family=Kaushan+Script" rel="stylesheet">
        <!-- Importing recaptcha -->
        <script src='https://www.google.com/recaptcha/api.js'></script>
        <!-- Importing jquery files -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="js/jquery.js" type="text/javascript"></script>
    </head>

    <body id="body-registration">
        <header>
            <div id="header-ccontainer">
                <div class="nav-title-container" >
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
                                <li class="nav-list-item"><a href="register.php" class="active" >Register</a></li>

                            </ul>
                        </div>
                        <div class="nav-button-wrapper">
                            <button type="button" class="button-login-mobile" onclick="window.parent.location.href = 'login.php'">Log In</button>
                            <button type="button" class="button-signin-mobile" onclick="window.parent.location.href = 'register.php'" >Sign In</button>
                        </div>
                    </div>
                </nav>
            </div>
        </header>

        <div id="cont">
     
                <div id="registration-container">
                    <form id ="form-registration" class="registration" method="post" action="register.php" novalidate="novalidate" >
                        <h1>Registration</h1>
                        <hr>
                        <div class="left">
                            <label for="first-name">First Name</label>
                            <input type="text" id="first-name" name="first-name" placeholder="First Name">
                        </div>
                        <div class="right">
                            <label for="last-name">Last Name</label>
                            <input type="text" id="last-name" name = "last-name" placeholder="Last Name">
                        </div>
                        <div class="both">
                            <label for="email">Email</label>
                            <input type="text" id="email" name="email" placeholder="you@example.org">
                            <label for="username">Username</label>
                            <input type="text" id="username" name="username" maxlength="15" placeholder="username" >
                            <label for="password">Password</label>
                            <input type="password" id="password" name="password" placeholder="*******">
                            <label for="confirm">Confirm Password</label>
                            <input type="password" id="confirm" name="confirm" placeholder="********">
                        </div>
                        <div class="checkbox-container">
                            <input id="checkbox-registration" name="checkbox-registration"  type="checkbox">
                            <label for="checkbox-registration">Two step login</label>              
                        </div>
                        <div class="g-recaptcha"  data-sitekey="6LeeKiMUAAAAAFB0HEs5IzMjWUbAb_I5EGn9Wdnd"></div>
                        <input id="button-submit-register" type="submit" name ="submit" value ="Register" >
                        <hr>
                    </form>
                </div>
      
        </div>

        <footer>
            <div id="footer-registration" class="footer">
                <a class="about-author" href="#">&copy; 2017. A. Martinčević</a>
            </div>
        </footer>
    </body>
</html>