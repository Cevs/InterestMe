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


        <div id="cont">
            <section>
                <div class="table-container">
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

<script>
    $(document).ready(function () {

        load_data();
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
                    console.log(json.length);
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
            load_data(this.id);
            $('#table-users-body').empty();

        });
    });
</script>