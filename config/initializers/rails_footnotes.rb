defined?(Footnotes) && Footnotes.setup do |f|
  # Wether or not to enable footnotes
  f.enabled = Rails.env.development?
  # You can also use a lambda / proc to conditionally toggle footnotes
  # Example :
  # f.enabled = -> { User.current.admin? }
  # Beware of thread-safety though, Footnotes.enabled is NOT thread safe
  # and should not be modified anywhere else.

  # Only toggle some notes :
  # f.notes = [:session, :cookies, :params, :filters, :routes, :env, :queries, :log, :general]
  f.notes += [:current_user]

  # Change the prefix :
  # f.prefix = 'mvim://open?url=file://%s&line=%d&column=%d'

  # Disable style :
  # f.no_style = true

  # Lock notes to top right :
  # f.lock_top_right = true

  # Change font size :
  # f.font_size = '11px'

  # Allow to open multiple notes :
  # f.multiple_notes = true
end

if defined?(Footnotes)
  module Footnotes
    module Notes
      class CurrentUserNote < AbstractNote
        # This method always receives a controller
        #
        def initialize(controller)
          @current_user = controller.instance_variable_get("@current_user")
        end

        # Returns the title that represents this note.
        #
        def title
          "Current user: #{@current_user.email}"
        end

        # This Note is only valid if we actually found an user
        # If it's not valid, it won't be displayed
        #
        def valid?
          @current_user
        end

        # The fieldset content
        #
        def content
          escape(@current_user.inspect)
        end
      end
    end
  end
end
