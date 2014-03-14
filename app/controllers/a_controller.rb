class AController <  EssayBaseController
  def score_card
    instance_variable_setup
    completed_essay = @user.total_responses.collect {|x| x.essay }.uniq.count
    pre_completed_essay = @user.responses_from_round.collect {|x| x.essay }.uniq.count
    @total_payment = 2.5*completed_essay
    @round_payment = 2.5*prev_completed_essay
    render :file => "essays/score_card.html.haml", :layout => false
  end
end
