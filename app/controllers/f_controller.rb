class FController < EssayBaseController
  def score_card
    @round_payment = 25
    @total_payment = @round * 25
    render file: 'essays/score_card.html.haml', layout: false
  end
end
