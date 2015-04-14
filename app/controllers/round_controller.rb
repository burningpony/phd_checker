class RoundController < AdminBaseController
  def create

    @user = User.find(params[:user_id])
    @round = Round.where(params[:round]).first_or_initialize(user_id: params [:user_id], round_number: params[:round_number])

    respond_to do |format|
      if @round.save
        format.json {render json: @round.to_json}
        format.html { redirect_to(@round, notice: 'Round was successfully created.') }
        format.xml  { render xml: @round, status: :created, location: @round }
      else
        format.json { render json: "#{ @round.errors}" }
        format.html { render action: 'new' }
      end
    end
  end
end