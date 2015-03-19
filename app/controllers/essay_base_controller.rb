class EssayBaseController < ApplicationController
  before_filter :instance_variable_setup, :only => [:score_card]
  after_filter :record_round, :only => [:score_card]

  def index
    @essays = []
    view_directory = File.expand_path('../../views/essays', __FILE__)
    Dir.foreach(view_directory).each do |view|
      if view.match(/(\d\d*)/)
        essay = view[/.*(?=\..+$)/][/.*(?=\..+$)/]
        essay_data = essay.split("_")
        @essays << {essay: essay_data[1].to_i, round: essay_data[0].to_i }
      end
    end
    @essays = @essays.sort{|a, b|  a[:essay] <=> b[:essay]}

    render file: 'essays/index', layout: 'default'
  end

  def show
    if params[:id] == 'practice'
      @essay_id = 'practice'
      @essay_title = 'Practice Essay'
      render file: 'essays/practice', layout: 'essay'
    else
      @essay_id = params[:id].match(/\d_\d+/)[0]
      @essay_title = "Essay #{@essay_id}"
      render file: 'essays/' + @essay_id, layout: 'essay'
    end
  end

  def show_quota_items
    false
  end

  def show_other_student_actions
    false
  end

  private

  def instance_variable_setup
    @user = User.find(params[:user_id])
    @total_responses = @user.responses
    @round = (params[:round_number] || 1).to_i
    @responses_from_round = @user.responses.where(round_number: @round)
    @time = params[:round_time]
  end

  def record_round
    Round.create!(user_id: @user.id, round_number: @round, treatment: self.class.to_s.gsub("Controller", ""), running_total_payment: @total_payment, round_payment: @round_payment, name: @name, time_to_complete_in_seconds: @time)
  end
end
