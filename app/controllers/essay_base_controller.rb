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
      render  :file => "essays/practice"
    else
      render  :file => "essays/" + params[:id].match(/\d+/)[0]      
    end
  end

  def sub_layout
    return nil
  end


end

