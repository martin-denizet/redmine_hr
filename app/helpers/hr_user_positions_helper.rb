module HrUserPositionsHelper

  def candidates_for_department(hr_department)
    User.active.all(:limit => 100, :order => 'login, lastname ASC',
      :conditions => ["#{User.table_name}.id NOT IN (?)",hr_department.member_ids.join(',')]
    )
  end
end