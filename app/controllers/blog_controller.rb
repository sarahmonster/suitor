class BlogController < ApplicationController
  before_filter :find_post, only: [:show]

  def index
    @posts = BlogPost.all
  end

  def show
    if stale?(@post, public: true)
      render text: @post.html, layout: true
    end
  end

  private
    def find_post
      @post = BlogPost.find params[:id]
      redirect_to blog_index_path unless @post
    end
end
