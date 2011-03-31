class BController <  EssayBaseControllerdef score_card
  def score_card
    @user = User.find(params[:participant_id])
    @responses = @user.responses
    
    @payment = 30
    render :file => "essays/score_card"
  end
end
