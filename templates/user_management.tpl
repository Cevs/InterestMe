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
                                <li class="nav-list-item" style="display:{$usersForm}"><a href="time.php" class="inactive" >System Time</a></li>
                                <li class="nav-list-item" style="display:{$timeConfigurationForm}"><a href="user_management.php" class="active">User Management</a></li>
                                <li class="nav-list-item" style="display:{$foiForm}"><a href="foi.php" class="inactive">Foi</a></li> >
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
            <div class="table-container">

                <table id="management-table" class="users-table">
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
                        <th>Lock</th>
                        <th>Unlock</th>

                    </tr>
                    <tbody id="table-users-body"></tbody>
                    <tfoot class="hide-if-no-paging" >
                    <td colspan = "6" >
                        {for $counter = 1 to $paging}
                            <button class="pagination-button" id="{$counter}" type="button">{$counter}</button>
                        {/for}
                    </td>
                    </tfoot>  
                    </tbody> 
                </table>
                <input id = "button-confirme" class="button-unlock" type="button" value = "Ok">

            </div>   
        </div>
        <footer>
            <div id="footer-usermanagement" class="footer">
                <a class="about-author" href="#">&copy; 2017. A. Martinčević</a>
            </div> 
        </footer>
    </body>

</html>

<script>
    $(document).ready(function () {

        var page = 1;

        load_data(page);
        function load_data(page) {
            $.ajax({
                url: "user_management_pagination.php",
                method: "POST",
                dataType: 'json',
                data: {
                    "page": page
                },

                success: function (json) {
                    var table = document.getElementById("table-users-body");
                    console.log("json:" + json.length);

                    for (var i = 0; i < json.length; i++) {
                        var row = table.insertRow(i);

                        var cellFirstname = row.insertCell(0);
                        var cellLastname = row.insertCell(1);
                        var cellUsername = row.insertCell(2);
                        var cellEmail = row.insertCell(3);
                        var cellRegistrationDate = row.insertCell(4);
                        var cellAttempts = row.insertCell(5);
                        var cellStatus = row.insertCell(6);
                        var cellLocked = row.insertCell(7);
                        var cellUnlocked = row.insertCell(8);

                        cellFirstname.innerHTML = json[i].firstname;
                        cellLastname.innerHTML = json[i].lastname;
                        cellUsername.innerHTML = json[i].username;
                        cellEmail.innerHTML = json[i].email;
                        cellRegistrationDate.innerHTML = json[i].registerdate;
                        cellAttempts.innerHTML = json[i].numberofattemps;
                        cellStatus.innerHTML = json[i].status;

                        if (json[i].status === "LOCKED") {
                            cellLocked.innerHTML = "<input type='checkbox' name='chk_lock[]' value = '" + json[i].username + "' disabled>";
                            cellUnlocked.innerHTML = "<input type='checkbox' name='chk_unlock[]'  value = '" + json[i].username + "'>";
                        } else {
                            cellLocked.innerHTML = "<input type='checkbox' name='chk_lock[]'  value = '" + json[i].username + "'>";
                            cellUnlocked.innerHTML = "<input type='checkbox' name='chk_unlock[]'  value = '" + json[i].username + "' disabled>";
                        }

                    }


                }
            });
        }


        function send_data(page, json_ckh_lock, json_ckh_unlock) {
            console.log("json_chk_lock: " + json_ckh_lock);
            console.log("json_chk_unlock: " + json_ckh_unlock);
            $.ajax({
                url: "user_management_pagination.php",
                method: "POST",
                dataType: 'json',
                data: {
                    "page": page,
                    "chk_lock": json_ckh_lock,
                    "chk_unlock": json_ckh_unlock
                },

                success: function (json) {
                    var table = document.getElementById("table-users-body");
                    console.log("Checkboxovi:" + json.length);

                    for (var i = 0; i < json.length; i++) {
                        var row = table.insertRow(i);

                        var cellFirstname = row.insertCell(0);
                        var cellLastname = row.insertCell(1);
                        var cellUsername = row.insertCell(2);
                        var cellEmail = row.insertCell(3);
                        var cellRegistrationDate = row.insertCell(4);
                        var cellAttempts = row.insertCell(5);
                        var cellStatus = row.insertCell(6);
                        var cellLocked = row.insertCell(7);
                        var cellUnlocked = row.insertCell(8);

                        cellFirstname.innerHTML = json[i].firstname;
                        cellLastname.innerHTML = json[i].lastname;
                        cellUsername.innerHTML = json[i].username;
                        cellEmail.innerHTML = json[i].email;
                        cellRegistrationDate.innerHTML = json[i].registerdate;
                        cellAttempts.innerHTML = json[i].numberofattemps;
                        cellStatus.innerHTML = json[i].status;

                        if (json[i].status === "LOCKED") {
                            cellLocked.innerHTML = "<input type='checkbox' name='chk_lock[]' value = '" + json[i].username + "' disabled>";
                            cellUnlocked.innerHTML = "<input type='checkbox' name='chk_unlock[]'  value = '" + json[i].username + "'>";
                        } else {
                            cellLocked.innerHTML = "<input type='checkbox' name='chk_lock[]'  value = '" + json[i].username + "'>";
                            cellUnlocked.innerHTML = "<input type='checkbox' name='chk_unlock[]'  value = '" + json[i].username + "' disabled>";
                        }

                    }


                }
            });
        }
        //get the id of clicked link
        $('.pagination-button').on('click', function () {
            page = this.id;
            console.log("Page: " + page);
            load_data(page);
            $('#table-users-body').empty();

        });

        $('#button-confirme').on('click', function () {


            var chk_lock_data = $("input[name='chk_lock[]']:checked").map(function () {
                return $(this).val();
            }).get();



            var chk_unlock_data = $("input[name='chk_unlock[]']:checked").map(function () {
                return $(this).val();
            }).get();



            var json_ckh_lock = JSON.stringify(chk_lock_data);
            var json_ckh_unlock = JSON.stringify(chk_unlock_data);

            send_data(page, json_ckh_lock, json_ckh_unlock);
            $('#table-users-body').empty();
        });


    });
</script>