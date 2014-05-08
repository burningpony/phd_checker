class CController <  EssayBaseController
  def score_card
    instance_variable_setup
    @total_payment = @total_responses.count * 0.45
    @round_payment = @responses_from_round.count * 0.45

    render :file => "essays/score_card.html.haml", :layout => false
  end
end
