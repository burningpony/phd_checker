class PhaseTwo::RoundsController < AdminBaseController
  def create
    @user = User.find(params[:user_id])
    @round = Round.where(user_id: params[:user_id], round_number: params[:round_number], option: params[:option], treatment: params[:treatment]).first_or_initialize

    if params[:early_exit]
      @round.early_exit = params[:early_exit]
    end

    respond_to do |format|
      if @round.save
        format.json { render json: @round.to_json }
        format.html { redirect_to(@round, notice: 'Round was successfully created.') }
        format.xml  { render xml: @round, status: :created, location: @round }
      else
        format.json { render json: "#{ @round.errors}" }
        format.html { render action: 'new' }
      end
    end
  end
end
