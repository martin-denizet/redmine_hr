class HrUserDetails < ActiveRecord::Base
  unloadable

  acts_as_customizable

  belongs_to :user, :class_name => 'User', :foreign_key => 'user_id'

  

end
