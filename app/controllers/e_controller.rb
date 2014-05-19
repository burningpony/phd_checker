class EController <  EssayBaseController
  def score_card
    round_completed_essay = @responses_from_round.map { |x| x.essay }.uniq.count
    total_completed_essay = @total_responses.map { |x| x.essay }.uniq.count
    @total_payment = 2.5 * round_completed_essay
    @round_payment = 2.5 * total_completed_essay

    render file: 'essays/score_card.html.haml', layout: false
  end

  def show_other_student_actions
    true
  end
end
