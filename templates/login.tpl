<!DOCTYPE html>
<html lang="hr">
    <head>
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



    <body id="body-registration">

        <div id="cont">
            <header>
                <div id="header-ccontainer">
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
                </div>
            </header>

            <section>
                <div class="form-container">
                    <form id ="form-login" class="login" method="post"  action="login.php" novalidate="novalidate" style="height:{$height};" autocomplete="off">
                        <h1>Login</h1>
                        <hr>
                        <label for="login-username">Username</label>
                        <input type="text" id="login-username" name="username" placeholder="username" value="{$username}">
                        <label for="login-password">Password</label>
                        <input type="password" id="login-password" name="password" placeholder="*******" value="{$password}">
                        <div id="forgot-container">
                            <a class="forgot-password" href = "identify.php">Forgot password?</a>
                        </div>
                        
                        <div  style="display:{$display}" >
                            <label for="verification">Verification</label>
                            <input type="password" id="verification" name="verification" placeholder="Secret Code">
                        </div>
                        <div>
                            {$message}
                        </div>
                        <div class="checkbox-container">
                            <input   id="checkbox-rememberme" name="checkbox-rememberme"  type="checkbox">
                            <label  for="checkbox-rememberme">Remember me</label>              
                        </div>
                        <input id="button-submit-login" name = "login" type="submit" value ="Login">
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
</html>