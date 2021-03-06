class DController <  EssayBaseController
  def score_card
    # 4.	Fee For Service plus Quota Bonus
    @total_payment =  @total_responses.count * 0.20
    @round_payment =  @responses_from_round.count * 0.20
    @name = 'D'
    # set the quota here
    @round_payment.count > 9 ? @payment += 1 : @round_payment

    @total_payment += @total_responses.group(:round_number).count.select { |_round, count| count > 9 }.size

    render file: 'essays/score_card', formats: [:html], layout: false
  end

  def show_quota_items
    true
  end
end
