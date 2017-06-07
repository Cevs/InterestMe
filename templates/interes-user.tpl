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
        <!-- Importing datepicker -->
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        
        <script >
            $( function() {
                $("#datepicker").datepicker({ dateFormat: "yy-mm-dd" }).val()
            } );
            

        </script>
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
                                <li class="nav-list-item" style="display:{$administrator}" ><a href="foi-management.php" class="inactive">Foi</a></li>
                                <li class="nav-list-item" style="display:{$administrator}"><a href="interes-user-management.php" class="active">interes-user</a></li>
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
            <form  method="post" action="interes-user.php">
                <label for="user-id">Username </label>
                <select id="user-id" name = "user-id" {if $action eq "update"}disabled{/if}>
                    {foreach from=$users key = id item = name}
                        {if $username eq $name}
                                 <option value = {$id} selected>{$name}</option>
                        {else}
                                 <option value="{$id}">{$name}</option>
                        {/if}

                    {/foreach}
                </select><br>
                <input name = "user-update-id"style="display:none"  value = {$userUpdateID}>
                
                <label for="interes-id">Filed of interest*</label>
                <select id="interes-id" name = "interes-id" {if $action eq "update"}disabled{/if}>
                    {foreach from=$interests key = id item = name}
                        {if $interes eq $name}
                                 <option value = {$id} selected>{$name}</option>
                        {else}
                                 <option value="{$id}">{$name}</option>
                        {/if}

                    {/foreach}
                </select><br>
                <input name = "interes-update-id" style="display:none"  value = {$interesUpdateID}>
                
                
                <div class="checkbox-container">
                    <label for="moderator">Moderator</label>   
                    {if $moderator eq 1}
                        <input id="moderator" name="moderator"  type="checkbox" checked="checked">
                    {else}
                        <input id="moderator" name="moderator"  type="checkbox" >
                    {/if}                             
                </div>
                
                
                <label for="datepicker">Date</label>
                <input type="text" id="datepicker" name="join-date" value="{$date}"><br>
         
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