//Run only when page Document Object Model(DOM) is ready for js to execute
$(document).ready(function () {

    $("#expand-collpase-button").click(hideShowNavigationMenu);
    $(window).resize(checkWindowSize);

    //change class to all child elements of parent .nav-list-item
    //REMOVED: $(".nav-list-item").on('click','a',changeState);
    //  -> Its causing problems with calling php scripts

    /*REMOVED
     * Remove all active class from navigation and replace it with inactive
     * Add active class to current selected navigation item
     * @return false
     */
    function changeState() {
        $(".nav-list-item>a").removeClass("active");
        $(".nav-list-item>a").addClass("inactive");

        if ($(this).hasClass("inactive")) {
            $(this).removeClass("inactive");
            $(this).addClass("active");
        }
        return false;
    }

    /*
     * Proccess on click event on button.
     * If navigation menu is visible, hide it and show corresponding icon.
     * 
     */
    function hideShowNavigationMenu() {

        if ($("#nav-list-items").is(":visible")) {
            $("#expand-collapse-picture").attr('src', "images/expand.png");
            $("#nav-list-items").hide();
        } else {
            $("#expand-collapse-picture").attr('src', "images/collapse.png");
            $("#nav-list-items").show();
        }
        return false;
    }

    /*
     * On window resize check if size is more than  700 px. 
     * If so, show navigation menu if hidden.
     */
    function checkWindowSize() {
        if (($(window).width() >= 700)) {
            $("#nav-list-items").show();
        }

    }


    /*-------------------------------------------------Register------------------------------------------------------*/

    var usernameExists = false;
    $("#username").focusout(function () {
        var username = $("#username").val();

        if (username !== '') {
            $.ajax({

                url: "username_handler.php",
                type: "post",
                async: false,
                data: {
                    "username": username
                },
                success: function (data) {
                    if (data.trim() == 0) {
                        usernameExists = false;
                    } else {
                        usernameExists = true;
                    }


                    if (usernameExists) {
                        setWarningUsername();
                    } else {
                        removeWarningUsername();
                    }

                    console.log("number of rows: " + data);
                }
            });
        } else {
            setWarningUsername();
        }
    });

    $("#first-name").focusout(function () {
        if (!(verificationFirstName()))
            setWarningFirstName();
        else
            removeWarningFirstName();
    });


    $("#last-name").focusout(function () {
        if (!verificationLastName()) {
            setWarningLastName();
        } else {
            removeWarningLastName();
        }
    });

    $("#email").focusout(function () {
        if (!verificationEmail()) {
            setWarningEmail();
        } else {
            removeWarningEmail();
        }
    });

    $("#password").focusout(function () {
        if (!verificationPassword()) {
            setWarningPassword();
        } else {
            removeWarningPassword();
        }
    });

    $("#confirm").focusout(function () {
        if (!vallidationPasswordConfirmPassword()) {
            setWarningConfirmPassword();
        } else {
            removeWarningConfirmPassword();
        }
    });


    function setWarningFirstName() {
        if (($("#first-name").hasClass("input-alert")))
            removeWarningFirstName();

        if (!($("#first-name").hasClass("input-alert"))) {
            var warning = "";
            if ($("#first-name").val() === "") {
                warning = "empty field";
            } else {
                warning = "incorrect first name";
            }

            $("#first-name").addClass("input-alert");
            $("#first-name").after('<p id ="text-first-name" class="alert-text" >' + warning + '</p>');
        }
    }
    function removeWarningFirstName() {
        if ($("#first-name").hasClass("input-alert")) {
            $("#first-name").removeClass("input-alert");
            $("#text-first-name").remove();
        }
    }

    function setWarningLastName() {
        if (($("#last-name").hasClass("input-alert"))) {
            removeWarningLastName();
        }
        if (!($("#last-name").hasClass("input-alert"))) {
            var warning = "";
            if ($("#last-name").val() === "") {
                warning = "empty field";
            } else {
                warning = "incorrect last name";
            }
            $("#last-name").addClass("input-alert");
            $("#last-name").after('<p id ="text-last-name" class="alert-text" >' + warning + '</p>');
        }
    }

    function removeWarningLastName() {
        if ($("#last-name").hasClass("input-alert")) {
            $("#last-name").removeClass("input-alert");
            $("#text-last-name").remove();
        }
    }

    function setWarningEmail() {
        if (($("#email").hasClass("input-alert")))
            removeWarningEmail();
        if (!($("#email").hasClass("input-alert"))) {
            var warning = "";
            if ($("#email").val() === "") {
                warning = "empty field";
            } else {
                warning = "incorrect email";
            }
            $("#email").addClass("input-alert");
            $("#email").after('<p id ="text-email" class="alert-text">' + warning + '</p>');
        }
    }

    function removeWarningEmail() {
        if ($("#email").hasClass("input-alert")) {
            $("#email").removeClass("input-alert");
            $("#text-email").remove();
        }
    }

    function setWarningPassword() {
        if (($("#password").hasClass("input-alert")))
            removeWarningPassword();
        if (!($("#password").hasClass("input-alert"))) {
            var warning = "";
            if ($("#password").val() === "") {
                warning = "empty field";
            } else {
                warning = "Password too weak";
            }
            $("#password").addClass("input-alert");
            $("#password").after('<p id ="text-password" class="alert-text">' + warning + '</p>');
        }
    }
    function removeWarningPassword() {
        if ($("#password").hasClass("input-alert")) {
            $("#password").removeClass("input-alert");
            $("#text-password").remove();
        }
    }

    function setWarningUsername() {
        if (($("#username").hasClass("input-alert")))
            removeWarningUsername();
        if (!($("#username").hasClass("input-alert"))) {
            var warning = "";
            if ($("#username").val() === "") {
                warning = "empty field";
            } else if (usernameExists) {
                warning = "Username already exists";
            }

            $("#username").addClass("input-alert");
            $("#username").after('<p id ="text-username" class="alert-text">' + warning + '</p>');

        }
    }

    function removeWarningUsername() {
        if (($("#username").hasClass("input-alert"))) {
            $("#username").removeClass("input-alert");
            $("#text-username").remove();

        }
    }

    function setWarningConfirmPassword() {
        if (($("#confirm").hasClass("input-alert")))
            removeWarningConfirmPassword();
        if (!($("#confirm").hasClass("input-alert"))) {
            var warning = "";
            if ($("#confirm").val() === "") {
                warning = "empty field";
            } else {
                warning = "The passwords do not match";
            }
            $("#confirm").addClass("input-alert");
            $("#confirm").after('<p id = "text-confirm-password" class="alert-text">' + warning + '</p>');
        }
    }

    function removeWarningConfirmPassword() {
        if (($("#confirm").hasClass("input-alert"))) {
            $("#confirm").removeClass("input-alert");
            $("#text-confirm-password").remove();
        }
    }



    /*-----------------------------------------------------------Register checks-----------------------------------------*/
    function verificationFirstName() {
        var firstName = $("#first-name").val();
        reFirstName = new RegExp("^[A-Z].+$");
        if (reFirstName.test(firstName))
            return true;
        return false;
    }

    function verificationLastName() {
        var lastName = $("#last-name").val();
        reLastName = new RegExp("^[A-Z].+$");
        if (reLastName.test(lastName))
            return true;
        return false;
    }



    function vallidationPasswordConfirmPassword() {
        var password = $("#password").val();
        var confirmPassword = $("#confirm").val();
        if (password === confirmPassword) {
            return true;
        }

        return false;
    }

    function verificationPassword() {
        var password = $("#password").val();
        var rePassword = new RegExp(/^(?=(.*[\d]){1,})(?=(.*[a-z]){2,})(?=(.*[A-Z]){2,})(?:[\da-zA-Z]){5,15}$/);
        if (rePassword.test(password) && (password !== '')) {
            return true;
        }
        return false;

    }

    function verificationEmail() {
        var email = $("#email").val();
        reEmail = new RegExp(/(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)/);
        if (reEmail.test(email)) {
            return true;
        } else {
            setWarningEmail();
            return false;
        }
    }


    $("#form-registration").submit(function (e) {
        if (!(verificationFirstName() && verificationLastName() && verificationPassword() && vallidationPasswordConfirmPassword() && verificationEmail() && !usernameExists)) {
            console.log("Username: " + usernameExists);
            // preventDefault must be at the beginning of block;
            e.preventDefault();
            if (!verificationFirstName())
                setWarningFirstName();
            if (!verificationLastName())
                setWarningLastName();
            if (!verificationPassword())
                setWarningPassword();
            if (!vallidationPasswordConfirmPassword())
                setWarningConfirm();
            if (!verificationEmail())
                setWarningEmail();

        }
    });



});