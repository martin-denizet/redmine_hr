class HrOrganizationalStructure < ActiveRecord::Base
  unloadable

  set_table_name :hr_organizational_structures

  acts_as_customizable
  
  acts_as_nested_set :order => 'position', :dependent => :destroy

  #accepts_nested_attributes_for :children # Creates an exception at the first call

  acts_as_list :scope => "type='#{@type}' AND parent_id='#{@parent_id}'"

  
  # Groups and active users
  #named_scope :active, :conditions => "#{Principal.table_name}.type='Group' OR (#{Principal.table_name}.type='User' AND #{Principal.table_name}.status = 1)"

  validates_presence_of :name
  #validates_uniqueness_of :name, :case_sensitive => false

  
  #  belongs_to :manager, :class_name => "User",
  #    :foreign_key => "manager_id"
  #  belongs_to :manager_job_title, :class_name => "HrJobTitle",
  #    :foreign_key => "manager_job_title_id"

  def init
    self.status=1
  end

  def to_s
    self.name
  end

  def active?
    true
  end

  def css_classes
    s = 'project'
    s << ' root' if root?
    s << ' child' if child?
    s << (leaf? ? ' leaf' : ' parent')
    s
  end

end
