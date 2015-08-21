jQuery(function() {
  $( ".select" ).click(function() {
    button = $(this)
    selection = $(this).closest(".option")
    window.option = $(this).val();
    console.log("option", window.option);
    $("#selected_option").text($(selection).find(".option_title").text())
    disableButtons();
    $(".options").fadeOut("fast", function(){
      $(".experiments").fadeIn("fast");
      enableButtons();
    });
  });

  $( ".back" ).click(function() {
    button = $(this)
    disableButtons();
    $(".experiments").fadeOut("fast", function(){
      $(".options").fadeIn("fast");
      enableButtons();
    });
  });

  $( ".begin" ).click(function() {
    disableButtons();
    payment_method = $(this).val();
    window.location = '/' + payment_method + '?option='+window.option
  });

  disableButtons = function(){
    $(".begin").attr("disabled", "disabled")
    $(".back").attr("disabled", "disabled")
    $(".select").attr("disabled", "disabled")
  }

  enableButtons = function(){
    $(".begin").removeAttr("disabled")
    $(".back").removeAttr("disabled")
    $(".select").removeAttr("disabled")
  }
});