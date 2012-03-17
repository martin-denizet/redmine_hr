class HrPosition < ActiveRecord::Base
  unloadable

  acts_as_list

  has_many :subordinates, :class_name => "HrPosition",
    :foreign_key => "manager_id"
    
  belongs_to :manager, :class_name => "HrPosition"
  #   :foreign_key => "manager_id"

  has_many :user_positions, :class_name => "HrUserPosition",
    :dependent => :delete_all, :foreign_key => "position_id"
  has_many :users, :through => :user_positions

  def to_s
    title
  end

  def user_ids

    collection = []
    :user.each { |u| collection << [u.login, u.id] }

  end
  
end
