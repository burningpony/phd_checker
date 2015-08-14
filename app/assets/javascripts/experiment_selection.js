jQuery(function() {
  $( ".select" ).click(function() {
    button = $(this)
    selection = $(this).closest(".experiment")
    window.payment_method = $(this).val();
    console.log("payment_method", window.payment_method);
    $("#selected_experiment").text($(selection).find(".experiment_title").text())
    disableButtons();
    $(".experiment").fadeOut("fast", function(){
      $(".options").fadeIn("fast");
      enableButtons();
    });
  });

  $( ".back" ).click(function() {
    button = $(this)
    disableButtons();
    $(".options").fadeOut("fast", function(){
      $(".experiment").fadeIn("fast");
      enableButtons();
      button.removeAttr("disabled")
    });
  });

  $( ".begin" ).click(function() {
    disableButtons();
    option = $(this).val();
    window.location = '/' + window.payment_method + '?option='+option
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