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
    function changeState(){
        $(".nav-list-item>a").removeClass("active");
        $(".nav-list-item>a").addClass("inactive");
       
        if($(this).hasClass("inactive")){
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
            $("#expand-collapse-picture").attr('src',"images/expand.png");
            $("#nav-list-items").hide();
        } else {
            $("#expand-collapse-picture").attr('src',"images/collapse.png");
            $("#nav-list-items").show();
        }
        return false;
    }

    /*
     * On window resize check if size is more than  700 px. 
     * If so, show navigation menu if hidden.
     */
    function checkWindowSize() {
        if (($(window).width() >= 700)){
            $("#nav-list-items").show();
        }
        
    }
    
});