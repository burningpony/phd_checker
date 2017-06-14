jQuery(function() {
    // Disable the delete key which will cause a back button event on firefox.
    $(document).on("keydown", function(e) {
        if (e.which === 8 && !$(e.target).is("input, textarea")) {
            e.preventDefault();
        }
    });
    // Disable f5 key from reloading the pag
    function disableF5(e) {
        if ((e.which || e.keyCode) == 116) e.preventDefault();
    }

    $(document).ready(function() {
        $(document).on("keydown", disableF5);
    });
});
