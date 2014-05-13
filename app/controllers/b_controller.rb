class BController <  EssayBaseController
  def score_card
    instance_variable_setup
    round_completed_essay = @responses_from_round.collect {|x| x.essay }.uniq.count
    total_completed_essay = @total_responses.collect {|x| [x.essay, x.round_number] }.uniq.count
    
    @total_payment = 0.85*total_completed_essay
    @round_payment = 0.85*round_completed_essay
    #set the quota here 
    
    @responses_from_round.count > 9 ? @round_payment += 1 : @round_payment

    @total_payment += @total_responses.group(:round_number).count.select{|round, count| count > 9}.size
    
    render :file => "essays/score_card.html.haml", :layout => false
  end
  
  
  def show_quota_items
    return true
  end
  
end
