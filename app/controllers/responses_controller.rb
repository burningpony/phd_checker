class ResponsesController < AdminBaseController
  # GET /responses
  layout proc { |c| c.request.xhr? ? false : 'application' }
  def index
    @responses = Response.order(:created_at).paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /responses/1
  def show
    @response = Response.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /responses/new
  def new
    @response = Response.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /responses/1/edit
  def edit
    @response = Response.find(params[:id])
  end

  def empty
    Response.delete_all
    User.delete_all
    @responses = []
    ActiveRecord::Base.connection.tables.each do |t|
      ActiveRecord::Base.connection.reset_pk_sequence!(t)
    end
    redirect_to responses_url
  end

  def export_raw_csv
    @responses = Response.all

    csv_string = Response.raw_csv(@responses)

    # send it to the browsah
    send_data csv_string,
              type: 'text/csv; charset=iso-8859-1; header=present',
              disposition: 'attachment; filename=raw_responses.csv'
  end

  # POST /responses
  def create
    @user = User.find(params[:user_id])
    @response =  @user.responses.where(error: params[:response][:error], round_number: params[:response][:round_number]).first_or_initialize(params[:response])

    respond_to do |format|
      if @response.save
        format.js
        format.html { redirect_to(@response, notice: 'Response was successfully created.') }

      else
        format.js { render js: "#{ @response.errors}" }
        format.html { render action: 'new' }

      end
    end
  end

  # PUT /responses/1
  def update
    @response = Response.find(params[:id])

    respond_to do |format|
      if @response.update_attributes(params[:response])
        format.html { redirect_to(@response, notice: 'Response was successfully updated.') }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /responses/1
  def destroy
    @response = Response.find(params[:id])
    @response.destroy

    respond_to do |format|
      format.html { redirect_to(responses_url) }
    end
  end
end
