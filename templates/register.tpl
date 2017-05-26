<!DOCTYPE html>
<html>
    <head>
        <title>InterestMe</title>
        <link rel="stylesheet" type="text/css" href="css/main.css">
        <link href="https://fonts.googleapis.com/css?family=Kaushan+Script" rel="stylesheet">
        <!-- Importing jquery files -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="js/index_jquery.js" type="text/javascript"></script> 
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
                            <button class="button-login">Log In</button>
                            <button type="button" class="button-singin" onclick="window.parent.location.href = 'register.php'" >Sing In</button>
                        </div>
                    </div>

                </nav>
            </header>
            <section>
                <div id="registration-container">

                    <form class="registration" method="post">
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
                            <input  id="checkbox-registration" name="checkbox-registration"  type="checkbox">
                            <label for="checkbox-registration">Two step login</label>              
                        </div>

                        <div class="button-submit-container">
                            <input id="button-submit" type="submit" value ="Register">
                        </div>
                        <hr>
                    </form>
                </div>

            </section>


            <footer>
                <div id="footer">
                    <a class="about-author" href="#">&copy; 2017. A. Martinčević<a>
                </div>
            </footer>
        </div>

    </body>
</html>