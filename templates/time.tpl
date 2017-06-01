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
        <div id="cont">
            <header>
                <div id="header-ccontainer">
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
                                    <li class="nav-list-item"><a  href="index.php" class="inactive" >Home</a></li>
                                    <li class="nav-list-item"><a  href="index.php" class="inactive" >Section1</a></li>
                                    <li class="nav-list-item"><a  href="time.php" class="active">System_time</a></li>

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
                    
                    <form  class="time-settings" method="post"  action="time.php" novalidate="novalidate">
                        <label for ="time-shift">Set system time offset:</label>
                        <input id ="time-shift" name = "time-shift" type="number" value="{$value}">
                        <input id = "button-submit-time" type="submit" name="submit" Value="set">
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