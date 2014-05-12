class FController <EssayBaseController
  def score_card
    instance_variable_setup
    @round_payment = 25
    @total_payment = (Integer(params[:round_number])-1) * 25
    render :file => "essays/score_card.html.haml", :layout => "default"
  end
  

end
