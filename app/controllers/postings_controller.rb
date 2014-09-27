class PostingsController < ApplicationController
  # after_action :verify_authorized, except: [:new, :create]

  def index
    # Restrict postings to this user.
    users_postings = policy_scope Posting.all

    case params[:sort]
      when 'date-added'
        @postings = users_postings.order('created_at DESC')
      when 'date-posted'
        @postings = users_postings.order('date_posted')
      when 'importance'
        @postings = users_postings.sorted_by_importance
      when 'status'
        @postings = users_postings.sorted_by_status
    end
  end

  def archived
    @postings = policy_scope Posting.archived
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
  end

  def create
    @posting = Posting.new(posting_params)
    @posting.user_id = current_user.id

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
