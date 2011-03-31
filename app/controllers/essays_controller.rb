class EssaysController < ApplicationController
  def index
    @essays = []
    view_directory = File.expand_path('../../views/essays', __FILE__)
    Dir.foreach(view_directory).each do |view|
      if view.match(/\d/)
        @essays << view
      end
    end
  end  
  def show
    render :action => params[:id].match(/\d+/)[0]
  end

  def get_responses_for_essay(essay, group)
    responses = Responses.find_all_by_essay_id(essay,group)
    
  end

  def scorecard_capitation

  end

  def capitation_quota_bonus

  end

  def fee_for_service

  end

  def fee_for_service_plus_quota_bonus

  end

  def socialization

  end

  def salary
    
  end
end

