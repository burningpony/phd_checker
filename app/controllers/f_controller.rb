class FController <EssayBaseController
  def score_card
    @user = User.find_or_create_by_id(params[:participant_id])
    @responses = @user.responses
    
    @payment = 25
    render :file => "essays/score_card.html.haml", :layout => false
  end
  

end
