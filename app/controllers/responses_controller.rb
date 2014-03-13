class ResponsesController < ApplicationController
  # GET /responses
  # GET /responses.xml
  layout proc{ |c| c.request.xhr? ? false : "application" }
  def index
    @responses = Response.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @responses }
    end
  end

  # GET /responses/1
  # GET /responses/1.xml
  def show
    @response = Response.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @response }
    end
  end

  # GET /responses/new
  # GET /responses/new.xml
  def new
    @response = Response.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @response }
    end
  end

  # GET /responses/1/edit
  def edit
    @response = Response.find(params[:id])
  end

  def empty
    Response.delete_all
    @responses = []
    redirect_to responses_url
  end

  def export_to_csv
    @responses = Response.find(:all)

    csv_string = FasterCSV.generate do |csv|
      # header row
      csv << ["id", "participant_id", "group", "error", "essay", "Correct?", "Field Before Correction","Seconds to Complete", "Time Corrected"]

      # data rows
      @responses.each do |response|
        csv << [response.id, response.user_id, response.user.group,response.error, response.essay, response.correct, response.uncorrected, response.user.time_to_complete, response.created_at ]
      end
    end

    # send it to the browsah
    send_data csv_string,
    :type => 'text/csv; charset=iso-8859-1; header=present',
    :disposition => "attachment; filename=responses.csv"
  end

  # POST /responses
  # POST /responses.xml
  def create

    @user = User.find_or_create_by_id(params[:participant_id], :group => params[:group])
    @response =  @user.responses.find_or_create_by_error_and_round_number(params[:response][:id], params[:response][:round_number])
    @response.update_attributes(params[:response])

    respond_to do |format|
      if @response.save
        format.js
        format.html { redirect_to(@response, :notice => 'Response was successfully created.') }
        format.xml  { render :xml => @response, :status => :created, :location => @response }

      else
        format.js {render :js => "#{ @response.errors}"}
        format.html { render :action => "new" }
        format.xml  { render :xml => @response.errors, :status => :unprocessable_entity }

      end
    end
  end

  # PUT /responses/1
  # PUT /responses/1.xml
  def update
    @response = Response.find(params[:id])

    respond_to do |format|
      if @response.update_attributes(params[:response])
        format.html { redirect_to(@response, :notice => 'Response was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @response.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /responses/1
  # DELETE /responses/1.xml
  def destroy
    @response = Response.find(params[:id])
    @response.destroy

    respond_to do |format|
      format.html { redirect_to(responses_url) }
      format.xml  { head :ok }
    end
  end
end
