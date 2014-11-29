class BlogController < ApplicationController
  before_filter :find_post, only: [:show]
  POSTS_PER_PAGE = 6

  def index
    unless params[:page] and params[:page].to_i >= 0
      @page = 0
    else
      @page = params[:page].to_i
    end

    @total_pages = (BlogPost.all.count / POSTS_PER_PAGE).ceil

    @posts = BlogPost.all.slice(@page * POSTS_PER_PAGE, POSTS_PER_PAGE)

    if @posts.blank?
      redirect_to(blog_index_path)
    end
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
