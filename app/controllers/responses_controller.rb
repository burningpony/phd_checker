class ResponsesController < AdminBaseController
  require 'csv'
  # GET /responses
  layout proc { |c| c.request.xhr? ? false : 'application' }
  def index
    @responses = Response.all

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
    @responses = []
    ActiveRecord::Base.connection.tables.each do |t|
      ActiveRecord::Base.connection.reset_pk_sequence!(t)
    end
    redirect_to responses_url
  end

  def export_to_csv
    @responses = Response.find(:all)

    csv_string = CSV.generate do |csv|
      # header row
      csv << [
        'id',
        'participant_id',
        'group',
        'error',
        'essay',
        'Correct?',
        'Field Before Correction',
        'Seconds to Complete',
        'Round',
        'Treatment',
        'Time Corrected'
      ]

      # data rows
      @responses.each do |response|
        csv << [
          response.id,
          response.user_id,
          response.user.group,
          response.error,
          response.essay,
          response.correct,
          response.uncorrected,
          response.round_number,
          response.user.time_to_complete,
          response.controller,
          response.created_at
        ]
      end
    end

    # send it to the browsah
    send_data csv_string,
              type: 'text/csv; charset=iso-8859-1; header=present',
              disposition: 'attachment; filename=responses.csv'
  end

  # POST /responses
  def create
    @user = User.find_or_create_by_id(params[:participant_id], group: params[:group])
    @response =  @user.responses.where(error: params[:response][:id], round_number: params[:response][:round_number]).first_or_initialize(params[:response])

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
