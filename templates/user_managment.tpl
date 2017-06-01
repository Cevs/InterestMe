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
                                    <li class="nav-list-item"><a  href="index.php" class="inactive" >Section2</a></li>
                                    <li class="nav-list-item"><a  href="index.php" class="inactive" >Section3</a></li>
                                    <li class="nav-list-item"><a href="unlock_users.php" class="active">Unlock</a></li>

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
                <div>
                    <form  method="post" action="user_managment.php" >
                        <table class="users-table">

                            <thead>
                                <tr>
                                    <td class="table-tittle" colspan="9">Locked Users</td>
                                </tr>
                            </thead>
                            <tr>  
                                <th>First Name</th>
                                <th>Last Name</th>
                                <th>Username</th>
                                <th>Email</th>
                                <th>Register date</th>
                                <th>Attempts</th>  
                                <th>Status</th>
                                <th>Unlock</th>
                                <th>Lock</th>
                            </tr>
                            {foreach from=$lockedusers item = user}
                                <tr>
                                    <td>{$user.firstname}</td>
                                    <td>{$user.lastname}</td>
                                    <td>{$user.username}</td>
                                    <td>{$user.email}</td>
                                    <td>{$user.registerdate}</td>
                                    <td>{$user.numberofattemps}</td>
                                    <td>{$user.status}</td>
                                    <td><input type="checkbox" name="chk_unlock[]" value="{$user.username}" {if $user.status eq 'UNLOCKED'}disabled{/if}></td>
                                    <td><input type="checkbox" name="chk_lock[]" value="{$user.username}" {if $user.status eq 'LOCKED'}disabled{/if}></td>
                                </tr>
                            {/foreach}   
                        </table>
                        <input class="button-unlock" type="submit" value = "Ok">
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