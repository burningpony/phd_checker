class DController <  EssayBaseController
  def score_card
    @user = User.find(params[:participant_id])
    @responses = @user.responses
   # 4.	Fee For Service plus Quota Bonus
    @payment =  @responses.count * 0.25
    
    
    #set the quota here 
    @responses.count > 1 ? @payment += 1 : @payment
    
    
render :file => "essays/score_card.html.haml", :layout => false
  end
  def show_quota_items
    return true
  end
  
end
