class FController <EssayBaseController
  def score_card
    @user = User.find(params[:participant_id])
    @responses = @user.responses
    
    @payment = 30
  end
end
