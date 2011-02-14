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

      @user_detail = UserDetails.find(:first, :conditions => ["user_id=?", @user.id])

      if @user_detail == nil
        @user_details = UserDetails.new
        @user_details.user_id = @user.id
        @user_detail.save()
      end

      if request.post?
        @user_detail.custom_field_values=params['user_details']['custom_field_values']
        @user_detail.save()
      end
    end
  end
end