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
        <header>
            <div id="header-container">
                <div class="nav-title-container">
                    <button id="expand-collpase-button">
                        <img id="expand-collapse-picture"  src="images/collapse.png" alt="button for collapsing or expending navigation view">
                    </button>

                    <h1 class="nav-title">InterestMe</h1>
                    <div class="nav-button-wrapper">
                        <button type="button" class="button-login" onclick="window.parent.location.href = '../login.php'" style ="display:{$loginDisplay}">Log In</button>
                        <button type="button" class="button-signin" onclick="window.parent.location.href = '../register.php'" style ="display:{$signinDisplay}">Sign In</button>
                        <button type="button" class="button-logout" onclick="window.parent.location.href = '../login.php'" style="display:{$logoutDisplay}">Log out</button>
                    </div>

                </div>
                <nav>
                    <div class="nav-container">
                        <div class="nav-links">
                            <ul id="nav-list-items">
                                <li class="nav-list-item"><a href="../index.php" class="inactive" >Home</a></li>
                                <li class="nav-list-item"><a href="korisnici.php" class="active" >Users</a></li>

                            </ul>
                            <div class="nav-button-wrapper">
                                <button type="button" class="button-login-mobile" onclick="window.parent.location.href = '../login.php'" style ="display:{$loginDisplay}">Log In</button>
                                <button type="button" class="button-signin-mobile" onclick="window.parent.location.href = '../register.php'" style ="display:{$signinDisplay}">Sign In</button>
                                <button type="button" class="button-logout-mobile" onclick="window.parent.location.href = '../login.php'" style="display:{$logoutDisplay}">Log out</button>
                            </div>
                        </div>
                    </div>
                </nav>
            </div>
        </header>

        <div id="cont">
            <div class="table-container" >
                <div class="search-container">

                    <input type="text" id="search-bar" placeholder="What can I help you with today?">
                </div>

                <table id="table-users" class="users-table">
                    <thead>
                        <tr>
                            <td class="table-tittle" colspan="6">Users</td>
                        </tr>
                    </thead>

                    <tr>
                        <th>
                            Username
                            <button type="button" id="button-ascending-username" class="table-button" >&uarr;</button>
                            <button id = "button-descending-username" class="table-button">&darr;</button>
                        </th>
                        <th>
                            Last Name
                            <button type="button" id="button-ascending-lastname" class="table-button" >&uarr;</button>
                            <button type="button" id = "button-descending-lastname" class="table-button" >&darr;</button>
                        </th>
                        <th>
                            First Name
                            <button type="button"  id="button-ascending-firstname" class="table-button" >&uarr;</button>
                            <button type="button" id = "button-descending-firstname" class="table-button" >&darr;</button>
                        </th>
                        <th>
                            Email
                            <button type="button" id="button-ascending-email" class="table-button" >&uarr;</button>
                            <button type="button" id = "button-descending-email" class="table-button" >&darr;</button>
                        </th>
                        <th>
                            Password
                            <button type="button" id="button-ascending-password" class="table-button" >&uarr;</button>
                            <button type="button" id = "button-descending-password" class="table-button" >&darr;</button>
                        </th>
                        <th>
                            User type
                            <button type="button" id="button-ascending-type" class="table-button" >&uarr;</button>
                            <button type="button" id = "button-descending-type" class="table-button" >&darr;</button>
                        </th>
                    </tr>


                    <tbody id="table-users-body"> </tbody>
                    <tfoot class="hide-if-no-paging" >
                    <td colspan = "6" >
                        {for $counter = 1 to $paging}
                            <button class="pagination-button" id="{$counter}">{$counter}</button>
                        {/for}
                    </td>
                    </tfoot>
                </table>
            </div>
        </div>

        <footer>
            <div id="footer-users" class="footer">
                <a class="about-author" href="#">&copy; 2017. A. Martinčević</a>
            </div> 
        </footer>
    </body>
</html>

<script type="text/javascript">
    $(document).ready(function () {
      
        var username = "none";
        var lastname = "none";
        var firstname = "none";
        var email = "none";
        var password = "none";
        var type = "none";
        var keyWords = "-1";
        var ajaxFinished  = true;
        
        var page = 1;

        load_data(page, keyWords, username, lastname, firstname, email, password, type);
        
        function load_data(page, keyWords, username, lastname, firstname, email, password, type) {
            console.log("page: "+page);
            console.log("keywords: "+keyWords);
            console.log("Username: "+username);
            console.log("Last name: "+lastname);
            console.log("First name: "+firstname);
            console.log("Email: "+email);
            console.log("Password: "+password);
            console.log("User type: "+type);
            $.ajax({
                url: "../private/users_pagination.php",
                method: "POST",
                dataType: 'json',
                data: {
                    "key-words":keyWords,
                    "page": page,
                    "username":username,
                    "lastname":lastname,
                    "firstname":firstname,
                    "email":email,
                    "password":password,
                    "type":type
                },

                success: function (json) {
                    var table = document.getElementById("table-users-body");
                    console.log("json:" + json.length);
                    for (var i = 0; i < json.length; i++) {
                        var row = table.insertRow(i);

                        var cellUsername = row.insertCell(0);
                        var cellLastname = row.insertCell(1);
                        var cellFirstname = row.insertCell(2);
                        var cellEmail = row.insertCell(3);
                        var cellPassword = row.insertCell(4);
                        var cellUsertype = row.insertCell(5);

                        cellUsername.innerHTML = json[i].username;
                        cellLastname.innerHTML = json[i].lastname;
                        cellFirstname.innerHTML = json[i].firstname;
                        cellEmail.innerHTML = json[i].email;
                        cellPassword.innerHTML = json[i].password;
                        cellUsertype.innerHTML = json[i].type;
                    }
                    ajaxFinished = true;
                },
                error: function (request, status, error) {
                    ajaxFinished = true;
                }
            });
        }

       
        //get the id of clicked link / page
        $('.pagination-button').on('click', function () {
            if(ajaxFinished === true){
                ajaxFinished = false;
                page = (this.id);
                load_data(page, keyWords, username, lastname, firstname, email, password, type);
                $('#table-users-body').empty();
            }
            
        });

        $('#search-bar').on('input', function () {
            keyWords = $('#search-bar').val();
            if (keyWords.length !== 0) {
                if(ajaxFinished === true){
                    ajaxFinished = false;
                    load_data(page, keyWords, username, lastname, firstname, email, password, type);
                    $('#table-users-body').empty();
                }
            } else {
                if(ajaxFinished === true){
                    ajaxFinished = false;
                    keyWords = -1;
                    load_data(1,keyWords, username, lastname, firstname, email, password, type);
                    $('#table-users-body').empty();
                }   
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


        $('#button-descending-password').on('click', function () {

            if ($('#button-descending-password').hasClass('pressed')) {
                $('#button-descending-password').removeClass('pressed');
                password = "none";
            } else {
                if ($('#button-ascending-password').hasClass('pressed')) {
                    $('#button-ascending-password').removeClass('pressed');
                }

                $('#button-descending-password').addClass('pressed');
                password = "DESC";
            }
        });

        $('#button-ascending-password').on('click', function () {

            if ($('#button-ascending-password').hasClass('pressed')) {
                $('#button-ascending-password').removeClass('pressed');
                password = "none";
            } else {
                if ($('#button-descending-password').hasClass('pressed')) {
                    $('#button-descending-password').removeClass('pressed');
                }

                $('#button-ascending-password').addClass('pressed');
                password = "ASC";
            }
        });
        
        
        $('#button-descending-type').on('click', function () {

            if ($('#button-descending-type').hasClass('pressed')) {
                $('#button-descending-type').removeClass('pressed');
                type = "none";
            } else {
                if ($('#button-ascending-type').hasClass('pressed')) {
                    $('#button-ascending-type').removeClass('pressed');
                }

                $('#button-descending-type').addClass('pressed');
                type = "DESC";
            }
        });

        $('#button-ascending-type').on('click', function () {

            if ($('#button-ascending-type').hasClass('pressed')) {
                $('#button-ascending-type').removeClass('pressed');
                type = "none";
            } else {
                if ($('#button-descending-type').hasClass('pressed')) {
                    $('#button-descending-type').removeClass('pressed');
                }

                $('#button-ascending-type').addClass('pressed');
                type = "ASC";
            }
        });
        
        //on any table button press call ajax function load date with given parameters
        $('.table-button').on('click', function(){
            if(ajaxFinished === true){
                ajaxFinished = false;
                keyWords = $('#search-bar').val();
                load_data(page, keyWords, username, lastname, firstname, email, password, type);
                //clean the table
                $('#table-users-body').empty();
            }
        });
    });
</script>