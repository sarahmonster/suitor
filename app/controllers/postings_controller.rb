class PostingsController < ApplicationController

	def index
		@postings = Posting.all
	end

	def show
		@posting = Posting.find(params[:id])
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
		@posting = Posting.find(params[:id])
	end

	def update
		@posting = Posting.find(params[:id])

		if @posting.update(posting_params)
			redirect_to @posting
		else
			render 'edit'
		end
	end

	def destroy
		@posting = Posting.find(params[:id])
		@posting.destroy
		redirect_to postings_path
	end


	private 
		def posting_params
				params.require(:posting).permit(:title, :description)
		end

end
