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
                                <li class="nav-list-item"><a href="index.php" class="active" >Home</a></li>
                                <li class="nav-list-item" style="display:{$administrator}"><a href="time.php" class="inactive" >System Time</a></li>
                                <li class="nav-list-item" style="display:{$administrator}"><a href="user_management.php" class="inactive">User Management</a></li>
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
            <form id="coupon-form" method="post" action = "coupon.php" enctype="multipart/form-data" novalidate="novalidate">
                <label for ="coupon-name">Name*</label>
                <input id ="coupon-name" name="coupon-name" type ="text"><br>
                <label for ="coupon-description">Description*</label>
                <textarea id="coupon-description" name="coupon-description" placeholder="Enter description"></textarea><br>
                <label for="coupon-image">Image</label>
                <div id="image_preview">
                    <img id="previewing"  />
                </div>

                <div id="selectImage">
                    <label>Select Image</label><br>
                    <input type="file" name="file" id="file" required>
                </div>

                <div id="selectVideo">
                    <label>Select Video</label><br>
                    <input type="file" name="video" id="video">
                </div>

                <div id="message"></div>

                <input type="hidden" name="MAX_FILE_SIZE" value="2097152" /> <!-- 2MB -->
                <input type="submit" value="Save">
            </form>
        </div>

        <footer>
            <div id="footer-index" class="footer">
                <a class="about-author" href="#">&copy; 2017. A. Martinčević</a>
            </div> 
        </footer>
    </body>

</html>


<script>
    $(document).ready(function (e) {
        var formData = new FormData();

        $("#coupon-from").on('submit', (function (e) {
            console.log("Coupon Name:" + $("#coupon-name").val());
            console.log("Coupon Name:" + $("#coupon-description").val());
            e.preventDefault();
            $("#message").empty();
            $.ajax({
                url: "coupon.php",
                type: "POST",
                data: new FormData(this),
                contentType: false,
                cache: false,
                processData: false,
                success: function (data)
                {
                    $("#message").html(data);
                }
            });
        }));

// Function to preview image after validation

        $("#file").change(function () {
            $("#message").empty();
            var file = this.files[0];
            var imagefile = file.type;
            var match = ["image/jpeg", "image/png", "image/jpg"];
            if (!((imagefile == match[0]) || (imagefile == match[1]) || (imagefile == match[2])))
            {
                console.log("krivi format");
                //$('#previewing').attr('src', 'noimage.png');
                $("#message").html("<p id='error'>Please Select A valid Image File</p>" + "<h4>Note</h4>" + "<span id='error_message'>Only jpeg, jpg and png Images type allowed</span>");
                return false;
            } else
            {
                var reader = new FileReader();
                reader.onload = imageIsLoaded;
                reader.readAsDataURL(this.files[0]);
            }
        });



        $("#video").change(function () {
            $("#message").empty();
            var file = this.files[0];
            var videofile = file.type;
            var match = ["video/mp4", "video/ogv", "video/webm"];
            if (!((videofile == match[0]) || (videofile == match[1]) || (videofile == match[2]))) {
                $("#message").html("<p id='error'>Please Select A valid video File</p>" + "<h4>Note</h4>" + "<span id='error_message'>Only mp4, webm and ogv video type allowed</span>");
            }
        });


        function imageIsLoaded(e) {
            $("#file").css("color", "green");
            $('#image_preview').css("display", "block");
            $('#previewing').attr('src', e.target.result);
            $('#previewing').attr('width', '250px');
            $('#previewing').attr('height', '230px');
        }
        ;
    });
</script>