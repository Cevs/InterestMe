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
                            Name
                            <button type="button" id="button-ascending-name" class="table-button" >&uarr;</button>
                            <button id = "button-descending-name" class="table-button">&darr;</button>
                        </th>
                        <th>
                            Description
                         
                        </th>
                        <th>
                            Page style
                            <button type="button" id="button-ascending-style" class="table-button" >&uarr;</button>
                            <button id = "button-descending-style" class="table-button">&darr;</button
                        </th>
                        <th>
                            Moderators
                            <button type="button" id="button-ascending-moderators" class="table-button" >&uarr;</button>
                            <button id = "button-descending-moderators" class="table-button">&darr;</button
                        </th>
                        <th>
                            Users
                            <button type="button" id="button-ascending-users" class="table-button" >&uarr;</button>
                            <button id = "button-descending-users" class="table-button">&darr;</button
                        </th>
                        <th>
                            Discussions
                            <button type="button" id="button-ascending-discussions" class="table-button" >&uarr;</button>
                            <button id = "button-descending-discussions" class="table-button">&darr;</button
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
                <input  class="button-unlock" type="button" value="Create Field of interest" onclick="window.parent.location.href = 'foi.php?action=insert'">
              
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
        
        var name = "none";
        var style = "none";
        var moderators = "none";
        var users = "none";
        var discussions = "none";
        var page = 1;
        var keyWords = "-1";
        var ajaxFinished = true;
        
        load_data(page, keyWords, name, style, moderators, users,discussions);

        function load_data(page, keyWords, name, style, moderators, users,discussions) {
            
            console.log("page: "+page);
            console.log("key words:"+keyWords);
            console.log("name:"+name);
            console.log("page style"+style);
            console.log("moderators:"+moderators);
            console.log("users:"+users);
            console.log("discussions:"+discussions);
            
            $.ajax({
                url: "foi-management-pagination.php",
                method: "POST",
                dataType: 'json',
                data: {
                    "page": page,
                    "key-words":keyWords,
                    "page-style":style,
                    "moderators":moderators,
                    "name":name,
                    "users":users,
                    "discussions":discussions
                },

                success: function (json) {
                    var table = document.getElementById("table-users-body");
                    console.log("json:" + json.length);

                    for (var i = 0; i < json.length; i++) {
                        var row = table.insertRow(i);

                        var cellUpdate = row.insertCell(0);
                        var cellDelete = row.insertCell(1);
                        var cellName = row.insertCell(2);
                        var cellDescription = row.insertCell(3);
                        var cellPageStyle = row.insertCell(4);
                        var cellModerators = row.insertCell(5);
                        var cellUsers = row.insertCell(6);
                        var cellDiscussions = row.insertCell(7);

                        cellUpdate.innerHTML = "<a href='foi.php?foiname="+json[i].name+" &action=update'><button  class='image-button' type='button' ><img class='table-image'  src='images/edit.png'></button></a>";
                        cellDelete.innerHTML = "<a href='foi.php?foiname="+json[i].name+" &action=delete'><button  class ='image-button' type='button'><img class='table-image'  src='images/delete.png'></button></a>";
                        cellName.innerHTML = json[i].name;
                        cellDescription.innerHTML = json[i].description;
                        cellPageStyle.innerHTML = json[i].style;
                        cellModerators.innerHTML = json[i].moderators;
                        cellUsers.innerHTML = json[i].users;
                        cellDiscussions.innerHTML = json[i].discussions;

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
                load_data(page, keyWords, name, style, moderators, users,discussions);
            }
        });

        $('#search-bar').on('input', function () {
            keyWords = $('#search-bar').val();
            if (keyWords.length !== 0) {
                if(ajaxFinished === true){
                    ajaxFinished = false;
                    $('#table-users-body').empty();
                    load_data(page, keyWords, name, style, moderators, users,discussions);
                }
            } else {
                keyWords = "-1";
                if(ajaxFinished === true){
                    ajaxFinished = false;
                    $('#table-users-body').empty();
                    load_data(1, keyWords, name, style, moderators, users,discussions);
                }
            }
        });


         $('#button-descending-name').on('click', function () {

            if ($('#button-descending-name').hasClass('pressed')) {
                $('#button-descending-name').removeClass('pressed');
                name = "none";
            } else {
                if ($('#button-ascending-name').hasClass('pressed')) {
                    $('#button-ascending-name').removeClass('pressed');
                }

                $('#button-descending-name').addClass('pressed');
                name = "DESC";
            }
        });

        $('#button-ascending-name').on('click', function () {

            if ($('#button-ascending-name').hasClass('pressed')) {
                $('#button-ascending-name').removeClass('pressed');
                name = "none";
            } else {
                if ($('#button-descending-name').hasClass('pressed')) {
                    $('#button-descending-name').removeClass('pressed');
                }

                $('#button-ascending-name').addClass('pressed');
                name = "ASC";
            }
        });
        
        $('#button-descending-style').on('click', function () {

            if ($('#button-descending-style').hasClass('pressed')) {
                $('#button-descending-style').removeClass('pressed');
                style = "none";
            } else {
                if ($('#button-ascending-style').hasClass('pressed')) {
                    $('#button-ascending-style').removeClass('pressed');
                }

                $('#button-descending-style').addClass('pressed');
                style = "DESC";
            }
        });

        $('#button-ascending-style').on('click', function () {

            if ($('#button-ascending-style').hasClass('pressed')) {
                $('#button-ascending-style').removeClass('pressed');
                style = "none";
            } else {
                if ($('#button-descending-style').hasClass('pressed')) {
                    $('#button-descending-style').removeClass('pressed');
                }

                $('#button-ascending-style').addClass('pressed');
                style = "ASC";
            }
        });
               
        $('#button-descending-moderators').on('click', function () {

            if ($('#button-descending-moderators').hasClass('pressed')) {
                $('#button-descending-moderators').removeClass('pressed');
                moderators = "none";
            } else {
                if ($('#button-ascending-moderators').hasClass('pressed')) {
                    $('#button-ascending-moderators').removeClass('pressed');
                }

                $('#button-descending-moderators').addClass('pressed');
                moderators = "DESC";
            }
            
            
        });

        $('#button-ascending-moderators').on('click', function () {

            if ($('#button-ascending-moderators').hasClass('pressed')) {
                $('#button-ascending-moderators').removeClass('pressed');
                moderators = "none";
            } else {
                if ($('#button-descending-moderators').hasClass('pressed')) {
                    $('#button-descending-moderators').removeClass('pressed');
                }

                $('#button-ascending-moderators').addClass('pressed');
                moderators = "ASC";
            }
        });

        $('#button-descending-users').on('click', function () {

            if ($('#button-descending-users').hasClass('pressed')) {
                $('#button-descending-users').removeClass('pressed');
                users ="none";
            } else {
                if ($('#button-ascending-users').hasClass('pressed')) {
                    $('#button-ascending-users').removeClass('pressed');
                }

                $('#button-descending-users').addClass('pressed');
                users = "DESC";
            }
        });

        $('#button-ascending-users').on('click', function () {

            if ($('#button-ascending-users').hasClass('pressed')) {
                $('#button-ascending-users').removeClass('pressed');
                users = "none";
            } else {
                if ($('#button-descending-users').hasClass('pressed')) {
                    $('#button-descending-users').removeClass('pressed');
                }

                $('#button-ascending-users').addClass('pressed');
                users = "ASC";
            }
        });

         $('#button-descending-discussions').on('click', function () {

            if ($('#button-descending-discussions').hasClass('pressed')) {
                $('#button-descending-discussions').removeClass('pressed');
                discussions ="none";
            } else {
                if ($('#button-ascending-discussions').hasClass('pressed')) {
                    $('#button-ascending-discussions').removeClass('pressed');
                }

                $('#button-descending-discussions').addClass('pressed');
                discussions = "DESC";
            }
        });

        $('#button-ascending-discussions').on('click', function () {

            if ($('#button-ascending-discussions').hasClass('pressed')) {
                $('#button-ascending-discussions').removeClass('pressed');
                discussions = "none";
            } else {
                if ($('#button-descending-discussions').hasClass('pressed')) {
                    $('#button-descending-discussions').removeClass('pressed');
                }

                $('#button-ascending-discussions').addClass('pressed');
                discussions = "ASC";
            }
        });
        
        //on any table button press call ajax function load date with given parameters
        $('.table-button').on('click', function(){
            keyWords = $('#search-bar').val();
            if(ajaxFinished===true){
                ajaxFinished = false;
                $('#table-users-body').empty();
                load_data(page, keyWords, name, style, moderators, users,discussions);
            }
            //clean the table 
        });
        
   
    });
</script>