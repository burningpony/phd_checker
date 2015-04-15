class FController < EssayBaseController
  def score_card
    @round_payment = 0
    @round_payment_override = "-"
    @total_payment = 25
    @name = "3"
    render file: 'essays/score_card', formats: [:html], layout: false
  end
end
