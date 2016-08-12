class SetupController < AdminBaseController
 # index view for experiments
  def experiment_options
    @options = ExperimentOption.all
    render 'experiments/options', layout: 'cover'
  end

  def available_payments
    @options = Payment.all
    @selected_option_name = params[:option_name]
    render 'experiments/available_payments', layout: 'cover'
  end

  def payment
    @selected_option_name = params[:option_name]
    available_payments = params[:available_payments]

    @experiments_options = Payment.find_all(available_payments) || Payment.all
    render 'experiments/payment', layout: 'cover'
  end
end
