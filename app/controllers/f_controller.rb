class FController < EssayBaseController
  def score_card
    payment = Payment.new(@option).f
    @round_payment = payment.round_payment
    @round_payment_override = '-'
    @total_payment = payment.total_payment
    @name = '3'
    render file: 'essays/score_card', formats: [:html], layout: false
  end
end
