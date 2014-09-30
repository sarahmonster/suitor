class PagesController < ApplicationController
  caches_page :home, :help, :about

  def home
  end

  def help
  end

  def about
  end

  def confirm_email_notice
  end

  def launch
    render :layout => 'skeleton'
  end
end
