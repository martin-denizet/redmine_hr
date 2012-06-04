class HrDepartment < HrOrganizationalStructure
  unloadable

  #attr_accessible :name

  validates_presence_of :organization_id, :if => Proc.new { |dpt|
    dpt.root?
  }

  belongs_to :organization, :class_name => "HrOrganization",
    :foreign_key => "organization_id"

  has_many :user_positions,  :class_name => "HrUserPosition", :as => :hr_structure, :dependent => :destroy

  has_many :members,  :class_name => 'User', :through => :user_positions, :source => :user

  has_one :manager_user_position,  :class_name => "HrUserPosition", :as => :hr_structure, :conditions => "is_manager = TRUE"

  has_one :manager,  :class_name => 'User', :through => :manager_user_position, :source => :user

  has_one :manager_job_title,  :class_name => 'HrJobTitle', :through => :manager_user_position, :source => :job_title



  named_scope :roots, lambda {|*args|
    {:conditions => ["#{self.table_name}.parent_id IS NULL"], :include => :user_positions}
  }

  #acts_as_list :scope => "type='#{self.class}' and parent_id='#{self.parent_id}'"

  #validates_uniqueness_of :name, :case_sensitive => false

  accepts_nested_attributes_for :manager_user_position, :reject_if => :all_blank

  before_save :set_manager_true

  def assign_parent(new_parent_id)
    if(new_parent_id.nil?||new_parent_id.to_i<0)
      return false
    end
    new_parent=HrDepartment.find(new_parent_id)
    self.move_to_child_of(new_parent.id)if new_parent
  end

  def set_manager_true
    manager_user_position.is_manager=true unless manager_user_position.nil?
  end


  def chart(parent)
    nodes=[]
    if manager_user_position

      nodes.concat(manager_user_position.chart(parent,self))

      self.user_positions.each do |member|
        nodes.concat(member.chart(manager_user_position.id,self))
      end

      self.children.each do |child|
        nodes.concat(child.chart(manager_user_position.id))
      end
    end
    nodes
  end

  def css_class
    'hr_department'
  end
  
end
