#3. In the next treatment, the players will have more help with their proofreading task. They will be provided with dropdown boxes with suggestions of how to correct the errors. I imagine it will look like this:
# a.   
# b.  These suggestions will each have a cost to the player. 
# i.  Was  5pts
# ii. Were 10 pts
# iii.  Wasn’t 2 pts
# iv. Etc.
# c.  The cost to the player will need to be reported above the finish button

class FController <EssayBaseController
  def score_card
    @user = User.find_or_create_by_id(params[:participant_id])
    @responses = @user.responses
    
    @payment = 25
    render :file => "essays/score_card.html.haml", :layout => false
  end
  

end