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
                        <button type="button" class="button-login" onclick="window.parent.location.href = 'login.php'" style ="display:{$loginDisplay}">Log In</button>
                        <button type="button" class="button-signin" onclick="window.parent.location.href = 'register.php'" style ="display:{$signinDisplay}">Sign In</button>
                        <button type="button" class="button-logout" onclick="window.parent.location.href = 'login.php'" style="display:{$logoutDisplay}">Log out</button>
                    </div>

                </div>
                <nav>
                    <div class="nav-container">
                        <div class="nav-links">
                            <ul id="nav-list-items">
                                <li class="nav-list-item"><a href="index.php" class="inactive" >Home</a></li>
                                <li class="nav-list-item" style="display:{$administrator}"><a href="time.php" class="inactive" >System Time</a></li>
                                <li class="nav-list-item" style="display:{$administrator}"><a href="user_management.php" class="inactive">User Management</a></li>
                                <li class="nav-list-item" style="display:{$administrator}"><a href="foi-management.php" class="active">Foi</a></li>
                                <li class="nav-list-item" style="display:{$administrator}"><a href="interes-user-management.php" class="inactive">interes-user</a></li>
                            </ul>
                            <div class="nav-button-wrapper">
                                <button type="button" class="button-login-mobile" onclick="window.parent.location.href = 'login.php'" style ="display:{$loginDisplay}">Log In</button>
                                <button type="button" class="button-signin-mobile" onclick="window.parent.location.href = 'register.php'" style ="display:{$signinDisplay}">Sign In</button>
                                <button type="button" class="button-logout-mobile" onclick="window.parent.location.href = 'login.php'" style="display:{$logoutDisplay}">Log out</button>
                            </div>
                        </div>
                    </div>
                </nav>
            </div>
        </header>

        <div id="cont">
            <form method="post" action="foi.php">
                <label for="foi-id">ID </label>
                <input id="foi-id" name = "foi-id" value="{$id}" readonly><br>
                <label for="field-of-interest">Filed of interest*</label>
                <input id="field-of-interest" type ="text" name="field-of-interest" placeholder="Name" value="{$name}"><br>
                <label for="foi-descripiton">Description*</label>
                <textarea id="foi-description" name="foi-description" rows="4" cols="50" placeholder="Enter text here...">{$description}</textarea><br>
                <label for="foi-theme">Theme</label>
                <select id="foi-theme" name="foi-theme">    
                    {foreach from=$themes key= key item = value}
                        {if $style eq $value}
                             <option value = {$key} selected>{$value}</option>
                        {else}
                             <option value="{$key}">{$value}</option>
                        {/if}
                       
                    {/foreach}
                </select>
                <input name ="action" style="display:none" value = "{$action}">
                <input type ="submit" name ="submit" value ="Ok">
                
            </form>
        </div>
    

        <footer>
            <div id="footer-index" class="footer">
                <a class="about-author" href="#">&copy; 2017. A. Martinčević</a>
            </div> 
        </footer>
    </body>

</html>