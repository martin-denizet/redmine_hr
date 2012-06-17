require 'dispatcher'
module RedmineHr
  module Patches
    module MyControllerPatch

      def self.included(base) # :nodoc:

        base.send(:include, InstanceMethods)

        base.class_eval do
          alias_method_chain :account, :user_details
        end

      end

      module InstanceMethods
        # Adds a rates tab to the user administration page
        def account_with_user_details
          (User.send(:include, HrUserPatch) unless User.included_modules.include?(HrUserPatch)) if RAILS_ENV == 'development'
          @user = User.current
          
          if @user.user_position
            unless @user.user_details
              @user.user_details = HrUserDetails.new
            end
            @user_details=@user.user_details
            
            if request.post?
              @user_details.update_attributes(params[:user][:user_details_attributes]) if params[:user][:user_details_attributes]
            
              if @user_details.save
                account_without_user_details
              else
                @user.safe_attributes = params[:user]
                @user.pref.attributes = params[:pref]
                @user.pref[:no_self_notified] = (params[:no_self_notified] == '1')
                @user.notified_project_ids = (@user.mail_notification == 'selected' ? params[:notified_project_ids] : [])
              end
            end
          end
        end
      end
    end
  end
end

Dispatcher.to_prepare do
  unless MyController.included_modules.include?(RedmineHr::Patches::MyControllerPatch)
    MyController.send(:include, RedmineHr::Patches::MyControllerPatch)
  end
end
