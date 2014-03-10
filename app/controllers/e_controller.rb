class EController <  EssayBaseController
  def score_card
    @user = User.find_or_create_by_id(params[:participant_id])
    @responses = @user.responses
    
    completed_essay = @user.responses.collect {|x| x.essay }.uniq.count
    @payment = 2.5 * completed_essay

    render :file => "essays/score_card.html.haml", :layout => false
  end
  def show_other_student_actions
    return true
  end
end
