class HrUserPosition < ActiveRecord::Base
  unloadable

  validates_uniqueness_of :user_id, :scope => [:hr_structure_type]

  belongs_to :job_title,
    #:dependent => :nullify,
  :class_name => "HrJobTitle",
    :foreign_key => "job_title_id"
  #:association_foreign_key => "position_id"

  belongs_to :user,
    :class_name => "User",
    :foreign_key => "user_id",
    :conditions => "status = 1"

  belongs_to :hr_structure, :polymorphic => true

  named_scope :subordinates, lambda {|*args|
    {:conditions => ["#{self.table_name}.is_manager IS NOT TRUE"]}
  }


  def <=>(another)
    self.user <=> another.user
  end

  def chart_caption
    "<div class='org_chart_avatar'>#{avatar(self.user, :size => "60")}</div>\n <div class='org_chart_content'><p>#{link_to_user self.user}</p><p>#{self.job_title}</p></div>"
  end

  def chart(parent,structure=nil)
    nodes=[]
    nodes << {:parent => parent, :structure => structure, :user_position=> self}
    nodes
  end
  #"[{v:'#{self.id}', f:'#{chart_caption}'},'#{parent}','']"

end
