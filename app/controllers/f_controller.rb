class FController <EssayBaseController
  def score_card
    @user = User.find(params[:participant_id])
    @responses = @user.responses
    
    @payment = 30
    render :file => "essays/score_card"
  end
  
  def show_other_student_actions
    return true
  end  
end