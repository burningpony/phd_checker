class BController <  EssayBaseController
  def score_card
    @user = User.find_or_create_by_id(params[:participant_id])
    @responses = @user.responses
    completed_essay = @user.responses.collect {|x| x.essay }.uniq.count
    @payment = 2.5*completed_essay
    #set the quota here 
    
    @responses.count > 9 ? @payment += 1 : @payment
    render :file => "essays/score_card.html.haml", :layout => false
  end
  
  
  def show_quota_items
    return true
  end
  
end
