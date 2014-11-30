class OffersController < ApplicationController
  after_action :verify_authorized, except: [:index]
  after_action :verify_policy_scoped, only: [:index]
  before_action :require_login
  before_action :set_offer, only: [:show, :edit, :update, :destroy]

  def index
    @offers = policy_scope(Offer.all)
  end

  def show
  end

  def new
    @offer = Offer.new
    authorize @offer
    @offer.posting = Posting.unscoped.find(params[:posting_id])
  end

  def edit
  end

  def create
    @offer = Offer.new(offer_params)
    @offer.posting = Posting.unscoped.find(params[:posting_id])
    authorize @offer
    authorize @offer.posting, :update?

    respond_to do |format|
      if @offer.save
        format.html { redirect_to @offer.posting, notice: 'Hey, way to go on the job offer! (We&rsquo;ve saved it for you.)' }
        format.json { render action: 'show', status: :created, location: @offer }
      else
        format.html { render action: 'new' }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @offer.update(offer_params)
      redirect_to @offer.posting, notice: 'We&rsquo;ve updated your job offer for you.'
    else
      render 'edit'
    end
  end

  def destroy
    @offer.destroy
    redirect_to @offer.posting
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_offer
      @offer = Offer.find(params[:id])
      @offer.posting = Posting.unscoped.find(params[:posting_id])
      authorize @offer
    end

    def offer_params
      params.require(:offer).permit(:salary, :details, :posting_id)
    end
end
