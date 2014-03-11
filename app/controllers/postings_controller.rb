class PostingsController < ApplicationController

	def new
	end

	def index
		@postings = Posting.all
	end

	def create
		@posting = Posting.new(posting_params)
		@posting.save
		redirect_to @posting
	end

	def show
		@posting = Posting.find(params[:id])
	end

	private 
		def posting_params
				params.require(:posting).permit(:title, :description)
		end

end
