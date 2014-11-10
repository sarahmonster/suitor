class OffersController < ApplicationController
  after_action :verify_authorized, except: [:index]
  after_action :verify_policy_scoped, only: [:index]
  before_action :require_login
  before_action :set_offer, only: [:show, :edit, :update, :destroy]

  def index
    @offers = policy_scope Offer.all
  end

  def show
  end

  def new
    @offer = Offer.new
    authorize @offer
  end

  def edit
  end

  def create
    @offer = Offer.new(offer_params)
    @offer.posting = Posting.unscoped.find(params[:posting_id])

    if @offer.save
      redirect_to @offer
    else
      render 'new'
    end
  end

  def update
    if @offer.update(offer_params)
      redirect_to @offer
    else
      render 'edit'
    end
  end

  def destroy
    @offer.destroy
    redirect_to @offer.posting
  end

  private
    def set_offer
      @offer = Offer.find(params[:id])
      authorize @offer
    end

    def offer_params
      params.require(:offer).permit(:salary, :details, :posting_id)
    end
end
