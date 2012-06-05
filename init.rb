require 'redmine'

# Patches to the Redmine core
require 'redmine_hr/patches/user_patch'
require 'redmine_hr/patches/my_controller_patch'
require 'redmine_hr/patches/custom_fields_helper_patch.rb'

# Customization hooks
# It requires the file in redmine_hr/hooks/hooks
require 'redmine_hr/hooks/hooks'

require 'awesome_nested_set'

RAILS_DEFAULT_LOGGER.info 'Starting HR plugin for Redmine'

Redmine::Plugin.register :redmine_hr do
  name 'Redmine HR plugin'
  author 'Martin Denizet'
  description 'Allows to give positions to users and generate an Organization Chart'
  version '0.1.2'
  url 'https://github.com/martin-denizet/redmine_hr'
  author_url 'https://github.com/martin-denizet'

  project_module :hr do

    permission :manage_hr_structures, {
      :hr_job_titles => [:new,:create,:edit,:update,:destroy],
      :hr_organizations => [:new,:create,:edit,:update,:destroy],
      :hr_departments => [:new,:create,:edit,:update,:destroy],
      :hr_user_details => [:new,:create,:edit,:update,:destroy]
    }

    permission :view_contact_list, {:hr => [:index,:contact_list]}
    permission :view_organization_chart, { :hr => :index, :hr_organizations => [:chart]}
    permission :view_employees_information, { :hr => [:index, :employees_information]}
    permission :manage_employees_information, { :hr_user_details => [:edit, :update], :hr => [:index,:employees_information]}
  end

  menu :top_menu, :position, { :controller => 'hr', :action => 'index'  },
    :if =>  Proc.new {
    User.current.allowed_to?({:controller => 'hr', :action => 'index'}, nil, :global => true)
  },
    :caption => :label_hr


end

#require 'dispatcher'
#Dispatcher.to_prepare :redmine_hr do
#  require_dependency 'user'
#  #SearchController.send(:include, RedmineEquipmentStatusViewer::Patches::SearchControllerPatch)
#  User.send(:include, HrUserPatch) unless User.included_modules.include?(HrUserPatch)
#    User.send(:include, HrUserPatch)
#  end
#end

