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
end
