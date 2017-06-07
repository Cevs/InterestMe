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
        
        <script>
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
                                <li class="nav-list-item" style="display:{$administrator}"><a href="user_management.php" class="active">User Management</a></li>
                                <li class="nav-list-item" style="display:{$administrator}"><a href="foi-management.php" class="inactive">Foi</a></li> 
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
            <form method="post" action="modify_user.php">
                <label for="user-id">ID </label>
                <input id="user-id" name = "user-id" value="{$id}" readonly><br>
                <label for="user-tpye">Type: </label>
                <select id="user-tpye" name="user-tpye">
                    {foreach from=$user_types key= k item = v}
                        {if $type eq $v}
                             <option value = {$k} selected>{$v}</option>
                        {else}
                             <option value="{$k}">{$v}</option>
                        {/if}
                       
                    {/foreach}
                </select><br>
                <label for="user-username">Username* </label>
                <input id="user-username" name="user-username" value="{$username}"><br>
                <label for="user-email">Email* </label>
                <input id="user-email" name="user-email" value="{$email}"><br>
                <label for="user-firstname">First name* </label>
                <input id="user-firstname" name="user-firstname" value="{$firstname}"><br>
                <label for="user-lastname">Last name* </label>
                <input id="user-lastname" name="user-lastname" value="{$lastname}"><br>
                <label for ="user-telephone-number">Telephone number</label>
                <input id="user-telephone-number" name="user-telephone-number" value="{$telephone_number}"><br>
                <label for="user-password">Password*</label>
                <input id="user-password" name="user-password" value="{$password}"><br>
                <label for="user-registration-date">Registration date*</label>
                <input type="text" id="datepicker" name="user-registration-date" value="{$registration_date}"><br>
                <div class="checkbox-container">
                    <label for="user-two-step-login">Two step login*</label>   
                    {if $two_step_login eq 1}
                        <input id="user-two-step-login" name="user-two-step-login"  type="checkbox" checked="checked">
                    {else}
                        <input id="user-two-step-login" name="user-two-step-login"  type="checkbox" >
                    {/if}                             
                </div>
                <label for="user-city">City</label>
                <input id="user-city" name="user-city" value="{$city}"><br>
                <label for="user-country">County</label>
                <input id="user-country" name="user-country" value="{$country}"><br>
                <label for="user-points">Points</label>
                <input id="user-points" name="user-points" value="{$points}"><br>
                <label for="user-access">Access</label>
                <input id="user-access" name="user-access" value="{$access}"><br>
                <label for="user-attempts">Attempts</label>
                <input id="user-attempts" name="user-attempts" value="{$attempts}"><br>
                <label for="user-account-status">Status</label>
                <input id ="user-account-status" name="user-account-status" value="{$account_status}"><br>
                <label for="user-code-time-expiration">Expiration time</label>
                <input id ="user-code-time-expiration"  name="user-code-time-expiration" value="{$expiration_time}"><br>
                <input name ="action" style="display:none" value = "{$action}">
                
                <input type="submit" name="submit" value="Save">
            </form>
                     
        </div>

        <footer>
            <div id="footer-index" class="footer">
                <a class="about-author" href="#">&copy; 2017. A. Martinčević</a>
            </div> 
        </footer>
    </body>

</html>

