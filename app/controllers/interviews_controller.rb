class InterviewsController < ApplicationController
  after_action :verify_authorized
  after_action :verify_policy_scoped, only: [:index]
  before_action :require_login
  before_action :set_interview, only: [:show, :edit, :update, :destroy]

  # GET /interviews
  # GET /interviews.json
  def index
    @posting = Posting.unscoped.find(params[:posting_id])
    authorize @posting, :show?

    @interviews = policy_scope Interview.where(posting_id: params[:posting_id])
  end

  # GET /interviews/1
  # GET /interviews/1.json
  def show
  end

  # GET /postings/:posting_id/interviews/new
  def new
    @interview = Interview.new
    authorize @interview
    @interview.posting = Posting.unscoped.find(params[:posting_id])
  end

  # GET /interviews/1/edit
  def edit
  end

  # POST /postings/:posting_id/interviews
  # POST /postings/:posting_id/interviews.json
  def create
    @interview = Interview.new(interview_params)
    @interview.posting = Posting.unscoped.find(params[:posting_id])
    authorize @interview
    authorize @interview.posting, :update?

    respond_to do |format|
      if @interview.save
        format.html { redirect_to @interview.posting, notice: 'Interview scheduled. Good luck!' }
        format.json { render action: 'show', status: :created, location: @interview }
      else
        format.html { render action: 'new' }
        format.json { render json: @interview.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /interviews/1
  # PATCH/PUT /interviews/1.json
  def update
    respond_to do |format|
      if @interview.update(interview_params)
        format.html { redirect_to [@interview.posting], notice: 'Interview details have been updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @interview.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /interviews/1
  # DELETE /interviews/1.json
  def destroy
    @interview.destroy
    respond_to do |format|
      format.html { redirect_to [@interview.posting], notice: 'You got it! Your interview&rsquo;s been removed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_interview
      @interview = Interview.find(params[:id])
      @interview.posting = Posting.unscoped.find(params[:posting_id])

      authorize @interview
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def interview_params
      params.require(:interview).permit(:datetime, :datetime_time, :datetime_date, :posting_id, :interviewer, :notes, :contact_method)
    end
end
