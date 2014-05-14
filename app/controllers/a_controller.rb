class AController <  EssayBaseController
  def score_card
    instance_variable_setup
    round_completed_essay = @responses_from_round.map { |x| x.essay }.uniq.count
    total_completed_essay = @total_responses.map { |x| [x.essay, x.round_number] }.uniq.count
    @total_payment = 0.85 * total_completed_essay
    @round_payment = 0.85 * round_completed_essay
    render file: 'essays/score_card.html.haml', layout: false
  end
end
