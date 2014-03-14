class FController <EssayBaseController
  def score_card
    instance_variable_setup
    @round_payment = 25
    @total_payment = @total_responses.select(:round_number).distinct.count
    render :file => "essays/score_card.html.haml", :layout => false
  end
  

end
