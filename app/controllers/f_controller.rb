class FController <EssayBaseController
  def score_card
    @user = User.find(params[:user_id])
    @responses = @user.responses
    
    @payment = 30
    render :file => "essays/score_card"
  end
end
