class PagesController < ApplicationController
  def home
  end

  def help
  end

  def about
  end

  def launch
    render :layout => 'skeleton'
  end
end
