module BlogHelper

  def blog_post?
    controller_name == 'blog' && action_name == 'show'
  end

end
