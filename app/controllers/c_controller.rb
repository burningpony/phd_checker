class CController <  EssayBaseController
  def score_card
    @total_payment = @total_responses.count * 0.20
    @round_payment = @responses_from_round.count * 0.20
    @name = '2'
    render file: 'essays/score_card', formats: [:html], layout: false
  end
end
