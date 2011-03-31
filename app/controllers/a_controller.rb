class AController <  EssayBaseController
  def score_card
    @user = User.find(params[:participant_id])
    @responses = @user.responses
    completed_essay = @user.responses.collect {|x| x.essay }.uniq.count
    @payment = 3*completed_essay
    render :file => "essays/score_card"
  end
end
