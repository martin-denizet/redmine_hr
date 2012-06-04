class HrUserDetails < ActiveRecord::Base
  unloadable
  
  acts_as_customizable

  validates_uniqueness_of :user_id

  validates_presence_of :user_id

  belongs_to :user, :class_name => 'User'

  accepts_nested_attributes_for :custom_values

  ## For columns selection
  def self.available_columns
    HrUserDetails.new.available_custom_fields
  end

end
