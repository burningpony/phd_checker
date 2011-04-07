class EssayBaseController < ApplicationController
  
  def index
    @essays = []
    view_directory = File.expand_path('../../views/essays', __FILE__)
    Dir.foreach(view_directory).each do |view|
      if view.match(/(\d\d*)/)
        @essays << $1.to_i
      end
    end
    @essays = @essays.sort
    
    render :file => "essays/index", :layout=> false
  end
    
  def show
    if params[:id] == 'practice'
      @essay_id = 'practice'
      @essay_title = "Practice Essay"
      render  :file => "essays/practice", :layout=>'essay'
    else
      @essay_id = params[:id].match(/\d+/)[0]
      @essay_title = "Essay #{@essay_id}"
      render  :file => "essays/" + @essay_id, :layout =>'essay'      
    end
  end

  def show_quota_items
    return false
  end

  def show_other_student_actions
    return false
  end

end

