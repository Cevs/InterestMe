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
                <form class="search-container">
                    <input type="text" id="search-bar" placeholder="What can I help you with today?">

                </form>
                <table id="management-table" class="users-table">
                    <thead>
                        <tr>
                            <td class="table-tittle" colspan="9">Locked Users</td>
                        </tr>
                    </thead>
                    <tr>  
                        <th>
                            First Name
                            <button type="button" id="button-ascending-firstname" class="table-button" >&uarr;</button>
                            <button id = "button-descending-firstname" class="table-button">&darr;</button>
                        </th>
                        <th>
                            Last Name
                            <button type="button" id="button-ascending-lastname" class="table-button" >&uarr;</button>
                            <button type="button" id = "button-descending-lastname" class="table-button" >&darr;</button>
                        </th>
                        <th>
                            Username
                            <button type="button" id="button-ascending-username" class="table-button" >&uarr;</button>
                            <button id = "button-descending-username" class="table-button">&darr;</button
                        </th>
                        <th>
                            Email
                            <button type="button" id="button-ascending-email" class="table-button" >&uarr;</button>
                            <button type="button" id = "button-descending-email" class="table-button" >&darr;</button>
                        </th>
                        <th>
                            Register date
                            <button type="button" id="button-ascending-registerdate" class="table-button" >&uarr;</button>
                            <button type="button" id = "button-descending-registerdate" class="table-button" >&darr;</button>
                        </th>
                        <th>
                            Attempts
                            <button type="button" id="button-ascending-attempts" class="table-button" >&uarr;</button>
                            <button type="button" id = "button-descending-attempts" class="table-button" >&darr;</button>
                        </th> 
                        <th>
                            Status
                            <button type="button" id="button-ascending-status" class="table-button" >&uarr;</button>
                            <button type="button" id = "button-descending-status" class="table-button" >&darr;</button>
                        </th>
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
        
        var username = "none";
        var firstname = "none";
        var lastname = "none";
        var username = "none";
        var email = "none";
        var registerdate ="none";
        var attempts = "none";
        var status = "none";
        var page = 1;
        var keyWords = "-1";
        var ajaxFinished = true;
        
        load_data(page, keyWords,firstname, lastname, username, email, registerdate, attempts, status);

        function load_data(page, keyWords,firstname, lastname, username, email, registerdate, attempts, status, json_ckh_lock, json_ckh_unlock) {
            
            console.log("page: "+page);
            console.log("key words:"+keyWords);
            console.log("firstname:"+firstname);
            console.log("lastname:"+lastname);
            console.log("username:"+username);
            console.log("email:"+email);
            console.log("registerdate:"+registerdate);
            console.log("attempts:"+attempts);
            console.log("status:"+status);
            $.ajax({
                url: "user_management_pagination.php",
                method: "POST",
                dataType: 'json',
                data: {
                    "page": page,
                    "key-words":keyWords,
                    "firstname":firstname,
                    "lastname":lastname,
                    "username":username,
                    "email":email,
                    "registerdate":registerdate,
                    "attempts":attempts,
                    "status":status,
                    "chk_lock": json_ckh_lock,
                    "chk_unlock": json_ckh_unlock
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
                     ajaxFinished = true;
                },
                error: function (request, status, error) {
                    ajaxFinished = true;
                }
            });
        }
        
        //get the id of clicked link
        $('.pagination-button').on('click', function () {
            page = this.id;
            console.log("Page: " + page);
            if(ajaxFinished === true){
                ajaxFinished = false;
                $('#table-users-body').empty();
                load_data(page, keyWords,firstname, lastname, username, email, registerdate, attempts, status);
            }
        });

        $('#search-bar').on('input', function () {
            keyWords = $('#search-bar').val();
            if (keyWords.length !== 0) {
                if(ajaxFinished === true){
                    ajaxFinished = false;
                    $('#table-users-body').empty();
                    load_data(page, keyWords,firstname, lastname, username, email, registerdate, attempts, status);
                }
            } else {
                keyWords = "-1";
                if(ajaxFinished === true){
                    ajaxFinished = false;
                    $('#table-users-body').empty();
                    load_data(1, keyWords,firstname, lastname, username, email, registerdate, attempts, status);
                }
            }
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
            if(ajaxFinished===true){
                ajaxFinished = false;
                load_data(page, keyWords,firstname, lastname, username, email, registerdate, attempts, status, json_ckh_lock, json_ckh_unlock);
                $('#table-users-body').empty();
            } 
        });
        
        
        
         $('#button-descending-firstname').on('click', function () {

            if ($('#button-descending-firstname').hasClass('pressed')) {
                $('#button-descending-firstname').removeClass('pressed');
                firstname = "none";
            } else {
                if ($('#button-ascending-firstname').hasClass('pressed')) {
                    $('#button-ascending-firstname').removeClass('pressed');
                }

                $('#button-descending-firstname').addClass('pressed');
                firstname = "DESC";
            }
        });

        $('#button-ascending-firstname').on('click', function () {

            if ($('#button-ascending-firstname').hasClass('pressed')) {
                $('#button-ascending-firstname').removeClass('pressed');
                firstname = "none";
            } else {
                if ($('#button-descending-firstname').hasClass('pressed')) {
                    $('#button-descending-firstname').removeClass('pressed');
                }

                $('#button-ascending-firstname').addClass('pressed');
                firstname = "ASC";
            }
        });
        
        $('#button-descending-lastname').on('click', function () {

            if ($('#button-descending-lastname').hasClass('pressed')) {
                $('#button-descending-lastname').removeClass('pressed');
                lastname = "none";
            } else {
                if ($('#button-ascending-lastname').hasClass('pressed')) {
                    $('#button-ascending-lastname').removeClass('pressed');
                }

                $('#button-descending-lastname').addClass('pressed');
                lastname = "DESC";
            }
        });

        $('#button-ascending-lastname').on('click', function () {

            if ($('#button-ascending-lastname').hasClass('pressed')) {
                $('#button-ascending-lastname').removeClass('pressed');
                lastname = "none";
            } else {
                if ($('#button-descending-lastname').hasClass('pressed')) {
                    $('#button-descending-lastname').removeClass('pressed');
                }

                $('#button-ascending-lastname').addClass('pressed');
                lastname = "ASC";
            }
        });
               
        $('#button-descending-username').on('click', function () {

            if ($('#button-descending-username').hasClass('pressed')) {
                $('#button-descending-username').removeClass('pressed');
                username = "none";
            } else {
                if ($('#button-ascending-username').hasClass('pressed')) {
                    $('#button-ascending-username').removeClass('pressed');
                }

                $('#button-descending-username').addClass('pressed');
                username = "DESC";
            }
            
            
        });

        $('#button-ascending-username').on('click', function () {

            if ($('#button-ascending-username').hasClass('pressed')) {
                $('#button-ascending-username').removeClass('pressed');
                username = "none";
            } else {
                if ($('#button-descending-username').hasClass('pressed')) {
                    $('#button-descending-username').removeClass('pressed');
                }

                $('#button-ascending-username').addClass('pressed');
                username = "ASC";
            }
        });

        $('#button-descending-email').on('click', function () {

            if ($('#button-descending-email').hasClass('pressed')) {
                $('#button-descending-email').removeClass('pressed');
                email ="none";
            } else {
                if ($('#button-ascending-email').hasClass('pressed')) {
                    $('#button-ascending-email').removeClass('pressed');
                }

                $('#button-descending-email').addClass('pressed');
                email = "DESC";
            }
        });

        $('#button-ascending-email').on('click', function () {

            if ($('#button-ascending-email').hasClass('pressed')) {
                $('#button-ascending-email').removeClass('pressed');
                email = "none";
            } else {
                if ($('#button-descending-email').hasClass('pressed')) {
                    $('#button-descending-email').removeClass('pressed');
                }

                $('#button-ascending-email').addClass('pressed');
                email = "ASC";
            }
        });


        $('#button-descending-registerdate').on('click', function () {

            if ($('#button-descending-registerdate').hasClass('pressed')) {
                $('#button-descending-registerdate').removeClass('pressed');
                registerdate = "none";
            } else {
                if ($('#button-ascending-registerdate').hasClass('pressed')) {
                    $('#button-ascending-registerdate').removeClass('pressed');
                }

                $('#button-descending-registerdate').addClass('pressed');
                registerdate = "DESC";
            }
        });

        $('#button-ascending-registerdate').on('click', function () {

            if ($('#button-ascending-registerdate').hasClass('pressed')) {
                $('#button-ascending-registerdate').removeClass('pressed');
                registerdate = "none";
            } else {
                if ($('#button-descending-registerdate').hasClass('pressed')) {
                    $('#button-descending-registerdate').removeClass('pressed');
                }

                $('#button-ascending-registerdate').addClass('pressed');
                registerdate = "ASC";
            }
        });
        
        
        $('#button-descending-attempts').on('click', function () {

            if ($('#button-descending-attempts').hasClass('pressed')) {
                $('#button-descending-attempts').removeClass('pressed');
                attempts = "none";
            } else {
                if ($('#button-ascending-attempts').hasClass('pressed')) {
                    $('#button-ascending-attempts').removeClass('pressed');
                }

                $('#button-descending-attempts').addClass('pressed');
                attempts = "DESC";
            }
        });

        $('#button-ascending-attempts').on('click', function () {

            if ($('#button-ascending-attempts').hasClass('pressed')) {
                $('#button-ascending-attempts').removeClass('pressed');
                attempts = "none";
            } else {
                if ($('#button-descending-attempts').hasClass('pressed')) {
                    $('#button-descending-attempts').removeClass('pressed');
                }

                $('#button-ascending-attempts').addClass('pressed');
                attempts = "ASC";
            }
        });
        
         $('#button-descending-status').on('click', function () {

            if ($('#button-descending-status').hasClass('pressed')) {
                $('#button-descending-status').removeClass('pressed');
                status = "none";
            } else {
                if ($('#button-ascending-status').hasClass('pressed')) {
                    $('#button-ascending-status').removeClass('pressed');
                }

                $('#button-descending-status').addClass('pressed');
                status = "DESC";
            }
        });

        $('#button-ascending-status').on('click', function () {

            if ($('#button-ascending-status').hasClass('pressed')) {
                $('#button-ascending-status').removeClass('pressed');
                status = "none";
            } else {
                if ($('#button-descending-status').hasClass('pressed')) {
                    $('#button-descending-status').removeClass('pressed');
                }

                $('#button-ascending-status').addClass('pressed');
                status = "ASC";
            }
        });
        
        //on any table button press call ajax function load date with given parameters
        $('.table-button').on('click', function(){
            keyWords = $('#search-bar').val();
            if(ajaxFinished===true){
                ajaxFinished = false;
                $('#table-users-body').empty();
                load_data(page, keyWords,firstname, lastname, username, email, registerdate, attempts, status);
            }
            //clean the table 
        });
    });
</script>