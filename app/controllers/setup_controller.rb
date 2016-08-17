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

  def select_job
    @selected_option_name = params[:option_name]
    @available_payments = params[:available_payments]

    # ;)
    @experiments_options = Proc.new {|job| Payment.find_all(@available_payments[job]) || Payment.all}
    @jobs = Job.all
    render 'experiments/select_job', layout: 'cover'
  end

  def payment
    @selected_option_name = params[:option_name]

    @experiments_options = Payment.all
    render 'experiments/payment', layout: 'cover'
  end
end
