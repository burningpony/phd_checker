jQuery(function() {
  $( ".select" ).click(function() {
    button = $(this)
    selection = $(this).closest(".option")
    window.option = $(this).val().split(":")[0];
    window.option_name = $(this).val().split(":")[1];
    console.log("option", window.option);
    $("#selected_option").text($(selection).find(".option_title").text())
    disableButtons();
    $(".options").fadeOut("fast", function(){
      $(".experiments").fadeIn("fast");
      enableButtons();
    });

    $.get('users/payment?option_name=' + window.option_name, function(
      data) {
        $("body").html(data);
        $( ".begin" ).click(function() {
          disableButtons();
          payment_method = $(this).val();
          window.location = '/' + payment_method + '?option='+window.option
        });
    });
  });

  disableButtons = function(){
    $(".begin").attr("disabled", "disabled")
    $(".select").attr("disabled", "disabled")
  }

  enableButtons = function(){
    $(".begin").removeAttr("disabled")
    $(".back").removeAttr("disabled")
    $(".select").removeAttr("disabled")
  }
});