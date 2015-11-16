class UsersController < AdminBaseController
  # GET /users
  layout proc { |c| c.request.xhr? ? false : 'application' }
  # GET /users.xml
  def index
    @users = User.all

    respond_to do |format|
      format.html { render layout: 'application' }
      format.xml  { render xml: @users }
    end
  end

  def mark_completed
    @user = User.find(params[:user_id])
    sum = @user.rounds.sum(:time_to_complete_in_seconds)
    @user.time_to_complete = sum
    @user.save
    render js: 'true'
  end

  # index view for experiments
  def options
    @options = ['essays', 'math_quizzes', 'combination']
    render 'experiments/options', layout: 'cover'
  end

  def payment
    @selected_option_name = params[:option_name]
    @experiments = ['a', 'c', 'f']
    render 'experiments/payment', layout: 'body'
  end

  def stats
    @users = User.find_all_by_group(params[:group])

    render layout: false
  end
  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html
      format.xml  { render xml: @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render xml: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(participant_id: params[:participant_id], group: params[:group])

    respond_to do |format|
      if @user.save

        format.json { render json: @user.to_json }
        format.html { redirect_to(@user, notice: 'User was successfully created.') }
        format.xml  { render xml: @user, status: :created, location: @user }
      else
        format.js { render js: "#{ @user.errors}" }
        format.html { render action: 'new' }
        format.xml  { render xml: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def export_aggregate_analysis
    @users = User.all
    csv_string = User.aggregate_analysis(@users)
    # send it to the browsah
    send_data csv_string,
              type: 'text/csv; charset=iso-8859-1; header=present',
              disposition: 'attachment; filename=formatted_responses.csv'
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, notice: 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render action: 'edit' }
        format.xml  { render xml: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end
