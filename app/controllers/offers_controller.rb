class OffersController < ApplicationController
  before_action :set_offer, only: [:show, :edit, :update, :destroy]

  def index
    @offers = Offer.all
    respond_with(@offers)
  end

  def show
    respond_with(@offer)
  end

  def new
    @offer = Offer.new
    #authorize @offer
    @offer.posting = Posting.unscoped.find(params[:posting_id])
  end

  def edit
  end

  def create
    @offer = Offer.new(offer_params)
    @offer.posting = Posting.unscoped.find(params[:posting_id])
    #authorize @offer
    #authorize @offer.posting, :update?

    respond_to do |format|
      if @offer.save
        format.html { redirect_to [@offer.posting], notice: 'Hey, way to go on the job offer! (We&rsquo;ve saved it for you.)' }
        format.json { render action: 'show', status: :created, location: @offer }
      else
        format.html { render action: 'new' }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @offer.update(offer_params)
    respond_with(@offer)
  end

  def destroy
    @offer.destroy
    respond_with(@offer)
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
