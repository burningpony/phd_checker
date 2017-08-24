class EssayBaseController < ApplicationController
  before_filter :instance_variable_setup, only: [:score_card]
  before_filter :get_phase, only: [:index, :show]
  after_filter :record_data, only: [:score_card]

  def index
    @option = params[:option] ||= 1
    @available_payments = params[:available_payments] || Payment.all
    @job = params[:job]
    @essays = []
    view_directory = File.expand_path("../../views/#{@phase}/options/#{@option}", __FILE__)
    Dir.foreach(view_directory).each do |view|
      if view.match(/(\d\d*)/)
        essay = view[/.*(?=\..+$)/][/.*(?=\..+$)/]
        essay_data = essay.split('_')
        @essays << { essay: essay_data[1].to_i, round: essay_data[0].to_i, type: type }
      end
    end
    @essays = @essays.sort { |a, b|  a[:essay] <=> b[:essay] }
    render file: 'essays/index', layout: 'default'
  end

  def show
    @option = params[:option]
    @essay_id = params[:id].match(/\d_\d+/)[0]
    @essay_title = "Essay #{@essay_id}"
    render file: "#{@phase}/options/#{params[:option]}/" + @essay_id, layout: 'essay'
  end

  def show_quota_items
    false
  end

  def show_other_student_actions
    false
  end

  private

  def type
    option = ExperimentOption.find(params[:option].to_i)
    I18n.t "type", scope: [:options, option[:name]]
  end

  def instance_variable_setup
    @user = User.find(params[:user_id])
    @round = Round.find(params[:round_id])
    @total_responses = @user.responses
    @round_number = (params[:round_number] || 1).to_i
    @responses_from_round = @user.responses.where(round_number: @round_number)
    @time = params[:round_time]
    @option = params[:option]
    @completed_in_time = params[:completed_in_time]
  end

  def record_data
    @user.update_attributes(total_payment: @total_payment)
    @round.update_attributes(user_id: @user.id, round_number: @round_number, running_total_payment: @total_payment, round_payment: @round_payment, name: @name, time_to_complete_in_seconds: @time, completed_in_time: @completed_in_time, early_exit: false, end_time: DateTime.now)
  end

  def get_phase
    @phase = params[:phase] == 'phase_one' ? 'phase_one' : 'phase_two'
  end
end
