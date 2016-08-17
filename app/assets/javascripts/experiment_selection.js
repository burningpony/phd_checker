//this is :(
jQuery(function() {
  $( ".select" ).click(function() {
    setOptionsToVal(this)
    console.log("option", window.option);
    //:()
    params = {option_name: window.option_name}

    if(window.option_name == "combination") {
      goToAvailablePaymentSelection(params)
    } else {
      goToPaymentSelection(params)
    }
  });

  setOptionsToVal = function(select) {
    window.option = $(select).val().split(":")[0];
    window.option_name = $(select).val().split(":")[1];
  }

  setAvailablePayments = function() {
    jobAPayments = $.map($('#job_a_payments').find("input:checked"), function(elem) {return elem.value})
    jobBPayments = $.map($('#job_b_payments').find("input:checked"), function(elem) {return elem.value})
    window.available_payments = {a: jobAPayments, b: jobBPayments}
  }

/**********************/
  goToAvailablePaymentSelection = function() {
    $.get('setup/available_payments', {option_name: window.option_name}, function(data) {
      $("body").html(data);
      $( ".submit" ).click(function(event) {
        setAvailablePayments()
        goToJobSelection({option_name: window.option_name,
                          available_payments: window.available_payments})
      });
    });
  }

/**********************/
  goToPaymentSelection = function(params) {
    $.get('setup/payment', params, function(data) {
      $("body").html(data);
      experiment_params = {option: window.option, available_payments: window.available_payments}

      $( ".begin" ).click(function(){
        payment_method = $(this).val();
        beginExperiment(payment_method, experiment_params)
      });
    });
  }

  goToJobSelection = function(params) {
    $.get('setup/select_job', params, function(data) {
      $("body").html(data);

      $( ".begin" ).click(function(){
        payment_method = $(this).val().split(":")[0];
        job = $(this).val().split(":")[1];

        experiment_params = {option: window.option,
                          available_payments: window.available_payments,
                          job: job}

        beginExperiment(payment_method, experiment_params)
      });
    });
  }

/*******************/
  beginExperiment = function(payment_method, params) {
    disableButtons();
    parametrized_params = $.param(params)
    window.location.href = '/' + payment_method + "?" + parametrized_params
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
