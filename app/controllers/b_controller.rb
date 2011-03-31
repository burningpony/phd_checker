class BController <  EssayBaseController
  def score_card
    @user = User.find(params[:participant_id])
    @responses = @user.responses
    completed_essay = @user.responses.collect {|x| x.essay }.uniq.count
    @payment = 3*completed_essay
    #set the quota here 
    @responses.count > 1 ? @payment += 1 : @payment
    render :file => "essays/score_card.html.haml"
  end
end
