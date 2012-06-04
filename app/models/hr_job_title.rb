class HrJobTitle < ActiveRecord::Base
  unloadable

  acts_as_list

  validates_presence_of :title
  validates_uniqueness_of :title, :case_sensitive => false
  validates_length_of :title, :within => (2 .. 60)

  alias :name :to_s


  has_many :user_positions, :class_name => 'HrUserPosition', :foreign_key => 'job_title_id', :dependent => :destroy

  has_many :users, :through => :user_positions

  def to_s
    title
  end

  def user_ids
    collection = []
    :user.each { |u| collection << [u.login, u.id] }
  end

  def self.find_all_givable
    find(:all, :order => 'position')
  end
  
end
