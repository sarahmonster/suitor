module DeviseHelper
  def devise_error_messages!
    unless request.method == 'GET'
      if resource.errors.empty? and !resource.id
        resource.errors.add('user', 'does not exist or password is incorrect')
      end
    end

    return "" if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg|
      content_tag(:li, msg)
    }.join
    sentence = I18n.t("errors.messages.not_saved",
                      count: resource.errors.count,
                      resource: resource.class.model_name.human.downcase)

    html = <<-HTML
    <div id="devise-errors">
      <ul>#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end

  def devise_error_messages?
    resource.errors.empty? ? false : true
  end
end
