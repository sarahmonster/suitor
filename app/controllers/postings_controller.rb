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
      @method = :sorted_by_importance
    end
  end

  def archived
    @postings = policy_scope(Posting.archived)
    @archive_page = true
    render 'index'
  end

  def archivetoggle
    @posting = Posting.unscoped.find(params[:id])
    authorize @posting
    @posting.toggle!(:archived)
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
    @posting = policy_scope Posting.unscoped.find(params[:id])
    authorize @posting
    @posting.destroy
    redirect_to postings_path
  end

  private
    def posting_params
        params.require(:posting).permit(:title, :description, :url, :date_posted, :job_location, :hiring_organization, :hiring_organization_url, :contact_name, :contact_email, :application_url, :deadline, :application_instructions)
    end

end
