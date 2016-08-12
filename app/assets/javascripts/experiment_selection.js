//this is :(
jQuery(function() {
  $( ".select" ).click(function() {
    setOptionsToVal(this)
    console.log("option", window.option);

    //:()
    if(window.option_name == "combination") {
      goToAvailablePaymentSelection(window.option_name)
    } else {
      goToPaymentSelection({option_name: window.option_name})
    }
  });

  setOptionsToVal = function(select) {
    window.option = $(select).val().split(":")[0];
    window.option_name = $(select).val().split(":")[1];
  }

  setAvailablePayments = function() {
    window.available_payments = $.map($('.available_payments').find("input:checked"), function(elem) {return elem.value})
  }

  goToAvailablePaymentSelection = function() {
    $.get('setup/available_payments', {option_name: window.option_name}, function(
      data) {
      $("body").html(data);
      $( ".submit" ).click(function(event) {
        setAvailablePayments()
        goToPaymentSelection({option_name: window.option_name,
                              available_payments: window.available_payments})
      });
    });
  }

  goToPaymentSelection = function(params) {
    $.get('setup/payment', params, function(
      data) {
        $("body").html(data);
        $( ".begin" ).click(function() {
          payment_method = $(this).val();
          disableButtons();
          params = $.param({option: window.option, available_payments: window.available_payments})
          window.location.href = '/' + payment_method + "?" + params
        });
    });
  }

  disableButtons = function(){
    $(".begin").attr("disabled", "disabled")
    $(".submit").attr("disabled", "disabled")
    $(".select").attr("disabled", "disabled")
  }

  enableButtons = function(){
    $(".begin").removeAttr("disabled")
    $(".back").removeAttr("disabled")
    $(".submit").removeAttr("disabled")
    $(".select").removeAttr("disabled")
  }
});
