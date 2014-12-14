class SuitorMailer < Devise::Mailer
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'devise/mailer' # to make sure that you mailer uses the devise views

  def confirmation_instructions(record, token, opts={})
    headers["X-MC-Tags"] = "confirmation,devise"
    super
  end

  def reset_password_instructions(record, token, opts={})
    headers["X-MC-Tags"] = "reset_password,devise"
    super
  end

  def unlock_instructions(record, token, opts={})
    headers["X-MC-Tags"] = "unlock,devise"
    super
  end
end
