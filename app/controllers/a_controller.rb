class AController <  EssayBaseController
  def score_card
    round_completed_essay = @responses_from_round.map(&:essay).uniq.count
    total_completed_essay = @total_responses.map(&:essay).uniq.count
    @total_payment = 0.625 * total_completed_essay
    @round_payment = 0.625 * round_completed_essay
    render file: 'essays/score_card.html.haml', layout: false
  end
end
