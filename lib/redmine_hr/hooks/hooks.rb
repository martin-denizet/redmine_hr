module HR
  class Hooks < Redmine::Hook::ViewListener
    def view_my_account(context={ })
      # the controller parameter is part of the current params object
      # This will render the partial into a string and return it.
      context[:controller].send(:render_to_string, {
          :partial => "hooks/hr/view_my_account",
          :locals => context
        })

      # Instead of the above statement, you could return any string generated
      # by your code. That string will be included into the view
    end

    def view_account_left_bottom(context={ })
      # the controller parameter is part of the current params object
      # This will render the partial into a string and return it.
      context[:controller].send(:render_to_string, {
          :partial => "hooks/hr/view_account_left_bottom",
          :locals => context
        })

      # Instead of the above statement, you could return any string generated
      # by your code. That string will be included into the view
    end

    def view_custom_fields_form_hr_user_details_custom_field(context={ })
      context[:controller].send(:render_to_string, {
          :partial => "hooks/hr/view_custom_fields_form_hr_user_details",
          :locals => context
        })
    end

    def view_my_account_contextual(context={ })
      context[:controller].send(:render_to_string, {
          :partial => "hooks/hr/view_my_account_contextual",
          :locals => context
        })
    end
  end
end

