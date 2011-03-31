class EssayBaseController < ApplicationController
  
  def index
    @essays = []
    view_directory = File.expand_path('../../views/essays', __FILE__)
    Dir.foreach(view_directory).each do |view|
      if view.match(/\d/)
        @essays << view
      end
    end
    render :file => "essays/index"
  end  
  def show
    render  :file => "essays/" + params[:id].match(/\d+/)[0]
  end


end

