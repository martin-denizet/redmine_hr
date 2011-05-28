require 'redmine'

# Patches to the Redmine core
require 'redmine_hr/patches/user_patch'
require 'redmine_hr/patches/my_controller_patch'

# Customization hooks
# It requires the file in redmine_hr/hooks/hooks
require 'redmine_hr/hooks/hooks'

RAILS_DEFAULT_LOGGER.info 'Starting HR plugin for RedMine'

Redmine::Plugin.register :redmine_hr do
  name 'Redmine HR plugin'
  author 'Martin Denizet'
  description 'Allows to give positions to users and generate a Organization Chart'
  version '0.1.0'
  url 'https://github.com/martin-denizet/redmine_hr'
  author_url 'https://github.com/martin-denizet'

  project_module :hr do
    permission :view_hr, {:hr => :index}
    permission :view_positions, {:positions => [:index,:show]}
    permission :manage_positions, {:positions => [:new,:edit,:destroy]}
    permission :view_organization_chart, {:positions => [:chart]}
    permission :view_contact_list, {:positions => [:contact_list]}
    permission :view_employees_information, {:employees => [:index]}
    permission :manage_employees_information, {:employees => [:edit]}

  end

  #Worktime
  project_module :worktime do
    
    permission :view_work_time_tab, {:work_time =>
        [:show,:total,:edit_relay,:relay_total,:relay_total2,:popup_select_issue,:ajax_select_issue,:popup_select_issues,:ajax_select_issues,:ajax_insert_daily,:ajax_memo_edit,:ajax_relay_table]}
    permission :edit_work_time_total, {}
    permission :view_work_time_other_member, {}
  end


  menu :top_menu, :position, { :controller => 'hr', :action => 'index'  },
    :if =>  Proc.new {
    User.current.allowed_to?({:controller => 'hr', :action => 'index'},nil, :global => true)
  },
    :caption => :label_hr

  #Worktime
  menu :top_menu, :last, { :controller => 'work_time', :action => 'index'  },
    :if =>  Proc.new {
    User.current.allowed_to?({:controller => 'work_time', :action => 'index'},nil, :global => true)
  },
    :caption => :work_time

  menu :account_menu, :work_time, {:controller => 'work_time', :action => 'index'}, :caption => :work_time
  menu :project_menu, :work_time, {:controller => 'work_time', :action => 'show'}, :caption => :work_time

  


end