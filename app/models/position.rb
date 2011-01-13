class Position < ActiveRecord::Base
  unloadable

  has_many :subordinates, :class_name => "Position",
    :foreign_key => "manager_id"
  belongs_to :manager, :class_name => "Position"
 #   :foreign_key => "manager_id"

  has_many :user_positions
  has_many :users, :through => :user_positions

  def to_s
    title
  end

  def user_ids

    collection = []

    :user.each { |u| collection << [u.login, u.id] }

  end
  
end
