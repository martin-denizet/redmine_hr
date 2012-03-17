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
      
          account_without_user_details
      
          @user = User.current
          @user_details = HrUserDetails.find(:first, :conditions => ["user_id=?", @user.id])
          @user_position =  HrUserPosition.find(:first, :conditions => ["user_id=?", @user.id])

          if @user_details == nil and @user_position != nil
            @user_details = HrUserDetails.new(:user_id => @user.id)
          end

          if request.post? and @user_position != nil
            @user_details.attributes = params[:user_details]
            if not @user_details.save
              # FIXME block the redirection in case of failure
              errors = ""
              @user_details.errors.each{|error| errors+=error.to_s}
              flash[:error] = errors
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
