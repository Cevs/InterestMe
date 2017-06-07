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
                                <li class="nav-list-item" style="display:{$administrator}"><a href="interes-user-management.php" class="inactive">interes-user</a></li>
                                <li class="nav-list-item" style="display:{$administrator}"><a href="coupon-management.php" class="active">Coupons</a></li>
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
                            Delete
                        </th>
                        <th>
                            Name
                            <button type="button" id="button-ascending-name" class="table-button" >&uarr;</button>
                            <button id = "button-descending-name" class="table-button">&darr;</button>
                        </th>
                        <th>
                            PDF   
                        </th>
                        <th>
                            Image
                        </th>
                        <th>
                            Video
                        </th>
                        <th>
                            Using
                            <button type="button" id="button-ascending-using" class="table-button" >&uarr;</button>
                            <button id = "button-descending-using" class="table-button">&darr;</button>
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
                <input  class="button-unlock" type="button" value="Create Coupon" onclick="window.parent.location.href = 'coupon.php?'">

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
        var using = "none";
        var page = 1;
        var keyWords = "-1";
        var ajaxFinished = true;

        load_data(page, keyWords, name, using);

        function load_data(page, keyWords, name, using) {

            console.log("page: " + page);
            console.log("key words:" + keyWords);
            console.log("name:" + name);

            $.ajax({
                url: "coupon-management-pagination.php",
                method: "POST",
                dataType: 'json',
                data: {
                    "page": page,
                    "key-words": keyWords,
                    "name": name,
                    "using": using
                },

                success: function (json) {
                    var table = document.getElementById("table-users-body");
                    console.log("json:" + json.length);

                    for (var i = 0; i < json.length; i++) {
                        var row = table.insertRow(i);


                        var cellDelete = row.insertCell(0);
                        var cellName = row.insertCell(1);
                        var cellPDF = row.insertCell(2);
                        var cellImg = row.insertCell(3);
                        var cellVideo = row.insertCell(4);
                        var cellUsing = row.insertCell(5);



                        cellDelete.innerHTML = "<a href='coupon.php?id=" + json[i].id + " &action=delete'><button  class ='image-button' type='button'><img class='table-image'  src='images/delete.png'></button></a>";
                        cellName.innerHTML = json[i].name;
                        cellPDF.innerHTML = "<a href='" + json[i].pdf + "' onclick='window.open('MyPDF.pdf', '_blank', 'fullscreen=yes'); return false;'>link</a>"
                        cellImg.innerHTML = "<a href='"+json[i].img+"' onclick = 'swipe();'>link</a>";
                        cellVideo.innerHTML = json[i].video;
                        cellUsing.innerHTML = json[i].using;


                    }
                    ajaxFinished = true;
                },
                error: function (request, status, error) {
                    ajaxFinished = true;
                }
            });
        }


        function swipe() {
            var largeImage = document.getElementById('largeImage');
            largeImage.style.display = 'block';
            largeImage.style.width = 200 + "px";
            largeImage.style.height = 200 + "px";
            var url = largeImage.getAttribute('src');
            window.open(url, 'Image', 'width=largeImage.stylewidth,height=largeImage.style.height,resizable=1');
        }
        //get the id of clicked link
        $('.pagination-button').on('click', function () {
            page = this.id;
            console.log("Page: " + page);
            if (ajaxFinished === true) {
                ajaxFinished = false;
                $('#table-users-body').empty();
                load_data(page, keyWords, name, using);
            }
        });

        $('#search-bar').on('input', function () {
            keyWords = $('#search-bar').val();
            if (keyWords.length !== 0) {
                if (ajaxFinished === true) {
                    ajaxFinished = false;
                    $('#table-users-body').empty();
                    load_data(page, keyWords, name, using);
                }
            } else {
                keyWords = "-1";
                if (ajaxFinished === true) {
                    ajaxFinished = false;
                    $('#table-users-body').empty();
                    load_data(1, keyWords, name, using);
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



        $('#button-descending-using').on('click', function () {

            if ($('#button-descending-using').hasClass('pressed')) {
                $('#button-descending-using').removeClass('pressed');
                using = "none";
            } else {
                if ($('#button-ascending-using').hasClass('pressed')) {
                    $('#button-ascending-using').removeClass('pressed');
                }

                $('#button-descending-using').addClass('pressed');
                using = "DESC";
            }
        });

        $('#button-ascending-using').on('click', function () {

            if ($('#button-ascending-using').hasClass('pressed')) {
                $('#button-ascending-using').removeClass('pressed');
                using = "none";
            } else {
                if ($('#button-descending-using').hasClass('pressed')) {
                    $('#button-descending-using').removeClass('pressed');
                }

                $('#button-ascending-using').addClass('pressed');
                using = "ASC";
            }
        });

        //on any table button press call ajax function load date with given parameters
        $('.table-button').on('click', function () {
            keyWords = $('#search-bar').val();
            if (ajaxFinished === true) {
                ajaxFinished = false;
                $('#table-users-body').empty();
                load_data(page, keyWords, name, using);
            }
            //clean the table 
        });


    });
</script>