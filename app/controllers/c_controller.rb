class CController <  EssayBaseController
  def score_card
    payment = Payment.new(@option).c(total_responses: @total_responses.count, responses_from_round: @responses_from_round.count)
    @total_payment =  payment.total_payment
    @round_payment =  payment.round_payment
    @name = '2'
    render file: 'essays/score_card', formats: [:html], layout: false
  end
end
