class PostingsController < ApplicationController

  def index
    @postings = Posting.all
  end

  def archived
    @postings = Posting.archived
    @archive_page = true
    render 'index'
  end

  def archivetoggle
    @posting = Posting.unscoped.find(params[:id])
    @posting.toggle!(:archived)
  end

  def show
    @posting = Posting.unscoped.find(params[:id])
    @posting.build_job_application unless @posting.job_application
  end

  def new
    @posting = Posting.new
  end

  def create
    @posting = Posting.new(posting_params)
    
    if @posting.save
      redirect_to @posting
    else
      render 'new'
    end
  end

  def edit
    @posting = Posting.unscoped.find(params[:id])
  end

  def update
    @posting = Posting.unscoped.find(params[:id])

    if @posting.update(posting_params)
      redirect_to @posting
    else
      render 'edit'
    end
  end

  def destroy
    @posting = Posting.unscoped.find(params[:id])
    @posting.destroy
    redirect_to postings_path
  end


  private 
    def posting_params
        params.require(:posting).permit(:title, :description, :url, :date_posted, :job_location, 
          :hiring_organization, :hiring_organization_url, :contact_name, :contact_email, 
          :application_url, :deadline, :application_instructions)
    end

end
