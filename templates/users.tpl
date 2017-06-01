<!DOCTYPE html>
<html lang="hr">
    <head >
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>InterestMe</title>
        <link rel="stylesheet" type="text/css" href="../css/main.css">
        <link href="https://fonts.googleapis.com/css?family=Kaushan+Script" rel="stylesheet">
        <!-- Importing jquery files -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="../js/jquery.js" type="text/javascript"></script> 
        <!-- Importing jquery files -->
    </head>

    <body id="user-print">
        <div id="cont">
            <header>
                <div id="header-ccontainer">
                    <div class="nav-title-container" >
                        <button id="expand-collpase-button">
                            <img id="expand-collapse-picture"  src="images/collapse.png"  >
                        </button>

                        <h1 class="nav-title">InterestMe</h1>
                    </div>

                    <nav>
                        <div class="nav-container">
                            <div class="nav-links">
                                <ul id="nav-list-items">
                                    <li class="nav-list-item"><a  href="../index.php" class="inactive" >Home</a></li>
                                    <li class="nav-list-item"><a  href="../index.php" class="inactive" >Section1</a></li>
                                    <li class="nav-list-item"><a  href="../index.php" class="inactive" >Section2</a></li>
                                    <li class="nav-list-item"><a  href="../index.php" class="inactive" >Section3</a></li>
                                    <li class="nav-list-item"><a href="korisnici.php" class="active" >Users</a></li>
                                  

                                </ul>
                            </div>
                            <div class="nav-button-wrapper">
                                <button type="button" class="button-login" onclick="window.parent.location.href = '../login.php'">Log In</button>
                                <button type="button" class="button-singin" onclick="window.parent.location.href = '../register.php'" >Sing In</button>
                            </div>
                        </div>

                    </nav>
                </div>
            </header>

            <section>
                <div>
                    <table class="users-table">
                        <tr>
                            <th>Username</th>
                            <th>Last Name</th>
                            <th>First Name</th>
                            <th>Email</th>
                            <th>Password</th>
                            <th>User type</th>
                        </tr>
                        
                        {foreach from=$user_array  item = user}
                            <tr>
                                <td>{$user.username}</td>
                                <td>{$user.lastname}</td>
                                <td>{$user.firstname}</td>
                                <td>{$user.email}</td>
                                <td>{$user.password}</td>
                                <td>{$user.type}</td>
                            </tr>
                        {/foreach}   
                    </table>
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