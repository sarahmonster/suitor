class PostingsController < ApplicationController
  after_action :verify_authorized, except: [:index, :archived]
  after_action :verify_policy_scoped, only: [:index, :archived]
  before_action :require_login

  def index
    @sortorder = params[:sort]
    case @sortorder
      when 'date-added'
        @method = :order, 'created_at DESC'
      when 'date-posted'
        @method = :order, 'date_posted'
      when 'status'
        @method = :sorted_by_status
    else
      @sortorder = 'importance'
      @method = :sorted_by_importance, current_user.followup_offset
    end
  end

  def archived
    @method = :archived
    @archive_page = true
    render 'index'
  end

  def archivetoggle
    @posting = Posting.unscoped.find(params[:id])
    authorize @posting

    respond_to do |format|
      if @posting.toggle!(:archived)
        format.html { redirect_to @posting }
        format.json { render json: @posting }
      else
        format.html { redirect_to @posting, error: "Posting couldn't be archived." }
        format.json { render json: @posting.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @posting = Posting.unscoped.find(params[:id])
    authorize @posting
    @posting.build_job_application unless @posting.job_application
    @interview = Interview.new(posting: @posting)
  end

  def new
    @posting = Posting.new
    authorize @posting
  end

  def create
    @posting = Posting.new(posting_params)
    @posting.user_id = current_user.id

    authorize @posting

    if @posting.save
      redirect_to @posting
    else
      render 'new'
    end
  end

  def edit
    @posting = Posting.unscoped.find(params[:id])
    authorize @posting
  end

  def update
    @posting = Posting.unscoped.find(params[:id])
    authorize @posting

    if @posting.update(posting_params)
      redirect_to @posting
    else
      render 'edit'
    end
  end

  def destroy
    @posting = Posting.unscoped.find(params[:id])
    authorize @posting
    @posting.destroy
    redirect_to postings_path
  end

  private
    def posting_params
      params.require(:posting).permit(:title, :description, :url, :date_posted, :job_location, :hiring_organization, :hiring_organization_url, :contact_name, :contact_email, :contact_number, :application_url, :deadline, :application_instructions)
    end
end
