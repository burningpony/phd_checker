class EController <  EssayBaseController
  def score_card
    instance_variable_setup
    round_completed_essay = @responses_from_round.collect {|x| x.essay }.uniq.count
    total_completed_essay = @total_responses.collect {|x| x.essay }.uniq.count
    @total_payment = 2.5 * round_completed_essay
    @round_payment = 2.5 * total_completed_essay

    render :file => "essays/score_card.html.haml", :layout => false
  end
  def show_other_student_actions
    return true
  end
end
