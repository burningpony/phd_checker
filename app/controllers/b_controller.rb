class BController <  EssayBaseController
  def score_card
    instance_variable_setup
    completed_essay = @total_responses.collect {|x| x.essay }.uniq.count
    
    prev_completed_essay = @responses_from_round.collect {|x| [x.essay x.round_number] }.uniq.count
    @total_payment = 2.5*completed_essay
    @round_payment = 2.5*prev_completed_essay
    #set the quota here 
    
    @responses_from_round.count > 9 ? @round_payment += 1 : @round_payment

    @total_payment += @total_responses.group(:round_number).count.select{|round, count| count > 9}.size
    
    render :file => "essays/score_card.html.haml", :layout => false
  end
  
  
  def show_quota_items
    return true
  end
  
end
