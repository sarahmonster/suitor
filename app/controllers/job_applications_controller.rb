class JobApplicationsController < ApplicationController
  after_action :verify_authorized
  after_action :verify_policy_scoped, only: [:index]
  before_action :require_login
  before_action :set_job_application, only: [:show, :edit, :update, :destroy, :followup]

  # GET /posting/1/job_application
  # GET /posting/1/job_application.json
  # def index
  #   @posting = Posting.unscoped.find(params[:posting_id])
  #   authorize @posting, :show?
  #   @job_applications = JobApplication.all
  # end

  # GET /posting/1/job_application
  # GET /posting/1/job_application.json
  def show
  end

  # GET /posting/1/job_application/new
  def new
    @job_application = JobApplication.new
    authorize @job_application
  end

  # GET /posting/1/job_application/edit
  def edit
  end

  # POST /posting/1/job_application
  # POST /posting/1/job_application.json
  def create
    @job_application = JobApplication.new(job_application_params)
    @job_application.posting = Posting.unscoped.find(params[:posting_id])
    authorize @job_application
    authorize @job_application.posting, :update?

    respond_to do |format|
      if @job_application.save
        # TODO: Is this line still needed?
        @job_application_is_new = true
        format.html {
          redirect_to @job_application.posting,
          notice: 'Job application was successfully created.'
        }
        format.json { render action: 'show', status: :created }
      else
        format.html { render action: 'new' }
        format.json {
          render json: @job_application.errors,
          status: :unprocessable_entity
        }
      end
    end
  end

  # PATCH/PUT /posting/1/job_application/followup.json
  def followup
    respond_to do |format|
      if @job_application.update(followup: Time.now)
        format.json { render action: 'show' }
      else
        format.json {
          render json: @job_application.errors,
          status: :unprocessable_entity
        }
      end
    end
  end

  # PATCH/PUT /posting/1/job_application
  # PATCH/PUT /posting/1/job_application.json
  def update
    respond_to do |format|
      if @job_application.update(job_application_params)
        format.html { redirect_to @job_application.posting, notice: 'Changes saved!' }
        format.json { render action: 'show', notice: 'Changes saved!' }
      else
        format.html { render action: 'edit' }
        format.json {
          render json: @job_application.errors,
          status: :unprocessable_entity
        }
      end
    end
  end

  # DELETE /posting/1/job_application
  # DELETE /posting/1/job_application.json
  def destroy
    @job_application.destroy
    respond_to do |format|
      format.html { redirect_to @job_application.posting }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job_application
      @job_application = Posting.unscoped.find(params[:posting_id]).job_application
      authorize @job_application
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_application_params
      params.require(:job_application).permit(:date_sent, :cover_letter, :posting_id)
    end
end
