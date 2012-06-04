class HrOrganization < HrOrganizationalStructure
  unloadable

  

  #attr_accessible :name
  has_many :departments,  :class_name => "HrDepartment", :foreign_key => "organization_id", :dependent => :destroy
  

  #has_many :members,  :class_name => "HrUserPositions", :through => :departments, :source => :members

  #has_many :members,  :class_name => "User", :foreign_key => "organization_id"

  #  has_many :members,  :class_name => "User", :through => :user_positions, :condition => "is_manager=FALSE"
  #
  #  has_one :manager,  :class_name => "User", :through => :user_positions, :condition => "is_manager=TRUE AND department_id IS NULL"

  has_one :manager_user_position,  :class_name => "HrUserPosition", :as => :hr_structure, :conditions => "is_manager = TRUE"

  has_one :manager,  :class_name => 'User', :through => :manager_user_position, :source => :user

  has_one :manager_job_title,  :class_name => 'HrJobTitle', :through => :manager_user_position, :source => :job_title

  #has_many :members,  :class_name => 'User', :through => :user_positions, :source => :user

  accepts_nested_attributes_for :manager_user_position, :reject_if => :all_blank


  before_save :set_manager_true

  def assign_parent(new_parent_id)
    if(new_parent_id.nil?||new_parent_id.to_i<0)
      return false
    else
      new_parent=HrOrganization.find(new_parent_id)
      self.move_to_child_of(new_parent.id)if new_parent
    end
  end

  def set_manager_true
    manager_user_position.is_manager=true unless manager_user_position.nil?
  end


  def chart(parent)
    nodes=[]
    if manager_user_position

      nodes.concat(manager_user_position.chart(parent,self))

      self.departments.each do |member|
        nodes.concat(member.chart(manager_user_position.id))
      end

      self.children.each do |child|
        nodes.concat(child.chart(manager_user_position.id))
      end
    end
    nodes
  end

  def css_class
    'hr_organization'
  end

end
