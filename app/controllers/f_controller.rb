class FController < EssayBaseController
  def score_card
    @round_payment = 25
    @total_payment = Integer(params[:round_number]) * 25
    render file: 'essays/score_card.html.haml', layout: false
  end
end
