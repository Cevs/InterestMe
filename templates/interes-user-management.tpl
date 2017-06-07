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
                                <li class="nav-list-item" style="display:{$administrator}"><a href="foi-management.php" class="inactive">Foi</a></li>
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
            <div class="table-container">
                <form class="search-container">
                    <input type="text" id="search-bar" placeholder="What can I help you with today?">

                </form>
                <table id="management-table" class="users-table">
                    <thead>
                        <tr>
                            <td class="table-tittle" colspan="11">Locked Users</td>
                        </tr>
                    </thead>
                    <tr>  
                     
                        <th>
                            Update
                        </th>
                          
                        <th>
                            Delete
                        </th>
                        <th>
                            Username
                            <button type="button" id="button-ascending-username" class="table-button" >&uarr;</button>
                            <button id = "button-descending-username" class="table-button">&darr;</button>
                        </th>
                        <th>
                            Interes
                            <button type="button" id="button-ascending-interes" class="table-button" >&uarr;</button>
                            <button id = "button-descending-interes" class="table-button">&darr;</button>
                        </th>
                        <th>
                            Moderator
                            <button type="button" id="button-ascending-moderator" class="table-button" >&uarr;</button>
                            <button id = "button-descending-moderator" class="table-button">&darr;</button>
                        </th>
                        <th>
                            Datum
                            <button type="button" id="button-ascending-date" class="table-button" >&uarr;</button>
                            <button id = "button-descending-date" class="table-button">&darr;</button
                        </th>
                      
                       
                    </tr>
                    <tbody id="table-users-body"></tbody>
                    <tfoot class="hide-if-no-paging" >
                    <td colspan = "5" >
                        {for $counter = 1 to $paging}
                            <button class="pagination-button" id="{$counter}" type="button">{$counter}</button>
                        {/for}
                    </td>
                    </tfoot>  
                    </tbody> 
                </table>
                <input  class="button-unlock" type="button" value="Create Field of interest" onclick="window.parent.location.href = 'interes-user.php?action=insert'">
              
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
        var interes = "none";
        var moderator = "none";
        var date = "none";
        var page = 1;
        var keyWords = "-1";
        var ajaxFinished = true;
        
        load_data(page, keyWords, username, interes, moderator, date);

        function load_data(page, keyWords, username, interes, moderator, date) {
            
            console.log("page: "+page);
            console.log("key words:"+keyWords);
            console.log("username:"+username);
            console.log("moderator"+moderator);
            console.log("date:"+date);
            console.log("interes:"+interes);
            
            $.ajax({
                url: "interes-user-management-pagination.php",
                method: "POST",
                dataType: 'json',
                data: {
                    "page": page,
                    "key-words":keyWords,
                    "username":username,
                    "moderator":moderator,
                    "date":date,
                    "interes":interes
                },

                success: function (json) {
                    var table = document.getElementById("table-users-body");
                    console.log("json:" + json.length);

                    for (var i = 0; i < json.length; i++) {
                        var row = table.insertRow(i);

                        var cellUpdate = row.insertCell(0);
                        var cellDelete = row.insertCell(1);
                        var cellUsername = row.insertCell(2);
                        var cellInteres = row.insertCell(3);
                        var cellModerator = row.insertCell(4);
                        var cellDate = row.insertCell(5);

                        cellUpdate.innerHTML = "<a href='interes-user.php?username="+json[i].username+"&interes="+json[i].interes+"&action=update'><button  class='image-button' type='button' ><img class='table-image'  src='images/edit.png'></button></a>";
                        cellDelete.innerHTML = "<a href='interes-user.php?username="+json[i].username+"&interes="+json[i].interes+"&action=delete'><button  class ='image-button' type='button'><img class='table-image'  src='images/delete.png'></button></a>";
                        cellUsername.innerHTML = json[i].username;
                        cellInteres.innerHTML = json[i].interes;
                        cellModerator.innerHTML = json[i].moderator;
                        cellDate.innerHTML = json[i].date;

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
                load_data(page, keyWords, username, interes, moderator, date);
            }
        });

        $('#search-bar').on('input', function () {
            keyWords = $('#search-bar').val();
            if (keyWords.length !== 0) {
                if(ajaxFinished === true){
                    ajaxFinished = false;
                    $('#table-users-body').empty();
                    load_data(page, keyWords, username, interes, moderator, date);
                }
            } else {
                keyWords = "-1";
                if(ajaxFinished === true){
                    ajaxFinished = false;
                    $('#table-users-body').empty();
                    load_data(1, keyWords, username, interes, moderator, date);
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
        
        $('#button-descending-interes').on('click', function () {

            if ($('#button-descending-interes').hasClass('pressed')) {
                $('#button-descending-interes').removeClass('pressed');
                interes = "none";
            } else {
                if ($('#button-ascending-interes').hasClass('pressed')) {
                    $('#button-ascending-interes').removeClass('pressed');
                }

                $('#button-descending-interes').addClass('pressed');
                interes = "DESC";
            }
        });

        $('#button-ascending-interes').on('click', function () {

            if ($('#button-ascending-interes').hasClass('pressed')) {
                $('#button-ascending-interes').removeClass('pressed');
                interes = "none";
            } else {
                if ($('#button-descending-interes').hasClass('pressed')) {
                    $('#button-descending-interes').removeClass('pressed');
                }

                $('#button-ascending-interes').addClass('pressed');
                interes = "ASC";
            }
        });
               
        $('#button-descending-moderator').on('click', function () {

            if ($('#button-descending-moderator').hasClass('pressed')) {
                $('#button-descending-moderator').removeClass('pressed');
                moderator = "none";
            } else {
                if ($('#button-ascending-moderator').hasClass('pressed')) {
                    $('#button-ascending-moderator').removeClass('pressed');
                }

                $('#button-descending-moderator').addClass('pressed');
                moderator = "DESC";
            }
            
            
        });

        $('#button-ascending-moderator').on('click', function () {

            if ($('#button-ascending-moderator').hasClass('pressed')) {
                $('#button-ascending-moderator').removeClass('pressed');
                moderator = "none";
            } else {
                if ($('#button-descending-moderator').hasClass('pressed')) {
                    $('#button-descending-moderator').removeClass('pressed');
                }

                $('#button-ascending-moderator').addClass('pressed');
                moderator = "ASC";
            }
        });

        $('#button-descending-date').on('click', function () {

            if ($('#button-descending-date').hasClass('pressed')) {
                $('#button-descending-date').removeClass('pressed');
                date ="none";
            } else {
                if ($('#button-ascending-date').hasClass('pressed')) {
                    $('#button-ascending-date').removeClass('pressed');
                }

                $('#button-descending-date').addClass('pressed');
                date = "DESC";
            }
        });

        $('#button-ascending-date').on('click', function () {

            if ($('#button-ascending-date').hasClass('pressed')) {
                $('#button-ascending-date').removeClass('pressed');
                date = "none";
            } else {
                if ($('#button-descending-date').hasClass('pressed')) {
                    $('#button-descending-date').removeClass('pressed');
                }

                $('#button-ascending-date').addClass('pressed');
                date = "ASC";
            }
        });

        
        //on any table button press call ajax function load date with given parameters
        $('.table-button').on('click', function(){
            keyWords = $('#search-bar').val();
            if(ajaxFinished===true){
                ajaxFinished = false;
                $('#table-users-body').empty();
                load_data(page, keyWords, username, interes, moderator, date);
            }
            //clean the table 
        });
        
   
    });
</script>