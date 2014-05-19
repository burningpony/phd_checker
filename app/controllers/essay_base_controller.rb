class EssayBaseController < ApplicationController
  before_filter :instance_variable_setup
  def index
    @essays = []
    view_directory = File.expand_path('../../views/essays', __FILE__)
    Dir.foreach(view_directory).each do |view|
      if view.match(/(\d\d*)/)
        @essays << Regexp.last_match[1].to_i
      end
    end
    @essays = @essays.sort

    render file: 'essays/index', layout: 'default'
  end

  def show
    if params[:id] == 'practice'
      @essay_id = 'practice'
      @essay_title = 'Practice Essay'
      render file: 'essays/practice', layout: 'essay'
    else
      @essay_id = params[:id].match(/\d+/)[0]
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
    @user = User.find_or_create_by_id(params[:participant_id])
    @total_responses = @user.responses
    @round = Integer(params[:round_number]) || 1
    previous_round = @round - 1
    @responses_from_round = @user.responses.where(round_number: previous_round)
  end
end
