require_dependency 'custom_fields_helper'
require 'dispatcher'
module RedmineHr
  module Patches
    module CustomFieldsHelperPatch
      def self.included(base) # :nodoc:
        base.send(:include, InstanceMethods)

        base.class_eval do
          alias_method_chain :custom_fields_tabs, :user_details_tab
          alias_method_chain :show_value, :is_public
        end
      end

      module InstanceMethods
        # Adds a rates tab to the user administration page
        def custom_fields_tabs_with_user_details_tab
          tabs = custom_fields_tabs_without_user_details_tab

          tabs << {:name => 'HrUserDetailsCustomField', :partial => 'custom_fields/index', :label => :label_user_details}
          return tabs
        end

        def show_value_with_is_public(custom_value)
          value = show_value_without_is_public(custom_value)
          custom_field=custom_value.custom_field
          if ((custom_field.type=='HrUserDetailsCustomField' and custom_field.is_public!=true) and not authorized_globally('hr','employees_information'))
            return l(:label_confidential_information)
          end
          return value
        end
      end
    end
  end
end

Dispatcher.to_prepare do
  unless CustomFieldsHelper.included_modules.include?(RedmineHr::Patches::CustomFieldsHelperPatch)
    CustomFieldsHelper.send(:include, RedmineHr::Patches::CustomFieldsHelperPatch)
  end
end
