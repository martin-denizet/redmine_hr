class UserPosition < ActiveRecord::Base
  unloadable

  belongs_to :position,
    #:dependent => :nullify,
    :class_name => "Position",
    :foreign_key => "position_id"
    #:association_foreign_key => "position_id"

  belongs_to :user,
    :class_name => "User",
    :foreign_key => "user_id",
    :conditions => "status = 1"

end
