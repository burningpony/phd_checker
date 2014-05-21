class AController <  EssayBaseController
  def score_card
    round_completed_essay = @responses_from_round.map { |x| x.essay }.uniq.count
    total_completed_essay = @total_responses.map { |x| [x.essay, x.round_number] }.uniq.count
    @total_payment = 0.625 * total_completed_essay
    @round_payment = 0.625 * round_completed_essay
    render file: 'essays/score_card.html.haml', layout: false
  end
end
