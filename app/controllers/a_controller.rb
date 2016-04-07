class AController <  EssayBaseController
  def score_card
    round_completed_essay = @responses_from_round.map(&:essay).uniq.count
    total_completed_essay = @total_responses.map(&:essay).uniq.count

    payment = Payment.new(@option).a(round_completed_essay: round_completed_essay, total_completed_essay: total_completed_essay)
    @total_payment = payment.total_payment
    @round_payment = payment.round_payment
    @name = '1'
    render file: 'essays/score_card', formats: [:html], layout: false
  end
end
