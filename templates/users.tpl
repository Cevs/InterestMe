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
            <form class="search-container">
                <input type="text" id="search-bar" placeholder="What can I help you with today?">

            </form>
            <div class="table-container" >
                <table id="table-users" class="users-table">
                    <thead>
                        <tr>
                            <td class="table-tittle" colspan="6">Users</td>
                        </tr>
                    </thead>

                    <tr>
                        <th>Username</th>
                        <th>Last Name</th>
                        <th>First Name</th>
                        <th>Email</th>
                        <th>Password</th>
                        <th>User type</th>
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
        load_data(1);
        function load_data(page) {
            $.ajax({
                url: "../private/users_pagination.php",
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


                }
            });
        }

        function search_data(keyWords) {
            $.ajax({
                url: "../private/users_pagination.php",
                method: "POST",
                dataType: 'json',
                data: {
                    "key-words": keyWords
                },

                success: function (json) {
                    var table = document.getElementById("table-users-body");
                    console.log(json.length);
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


                }
            });
        }
        //get the id of clicked link
        $('.pagination-button').on('click', function () {
            load_data(this.id);
            $('#table-users-body').empty();
        });

        $('#search-bar').on('input', function () {
            console.log(($('#search-bar').val()));
            var keyWords = 1;
            keyWords = $('#search-bar').val();
            console.log("key words:" + keyWords.length);
            if (keyWords.length !== 0) {
                search_data(keyWords);
                $('#table-users-body').empty();
            } else {
                load_data(1);
            }

        });
    });
</script>