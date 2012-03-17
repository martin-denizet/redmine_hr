require 'redmine'

# Patches to the Redmine core
require_dependency 'redmine_hr/patches/user_patch'
require 'redmine_hr/patches/my_controller_patch'
require 'redmine_hr/patches/custom_fields_helper_patch.rb'

# Customization hooks
# It requires the file in redmine_hr/hooks/hooks
require 'redmine_hr/hooks/hooks'

RAILS_DEFAULT_LOGGER.info 'Starting HR plugin for RedMine'

Redmine::Plugin.register :redmine_hr do
  name 'Redmine HR plugin'
  author 'Martin Denizet'
  description 'Allows to give positions to users and generate a Organization Chart'
  version '0.1.2'
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

  menu :top_menu, :position, { :controller => 'hr', :action => 'index'  },
    :if =>  Proc.new {
    User.current.allowed_to?({:controller => 'hr', :action => 'index'},nil, :global => true)
  },
    :caption => :label_hr


end