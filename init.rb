require 'redmine'
# It requires the file in lib/hr/hooks.rb
require_dependency 'hr/hooks'
require 'user'

# Patches to the Redmine core
require 'dispatcher'

Dispatcher.to_prepare :redmine_hr do

  require_dependency 'custom_fields_helper'
  CustomFieldsHelper.send(:include, CustomFieldsHelperPatch) unless CustomFieldsHelper.included_modules.include?(CustomFieldsHelperPatch)

  require_dependency 'my_controller'
  MyController.send(:include, MyControllerPatch) unless MyController.included_modules.include?(MyControllerPatch)


end


Redmine::Plugin.register :redmine_hr do
  name 'Redmine HR plugin'
  author 'Martin Denizet'
  description 'Allows to give positions to users and generate a Organization Chart'
  version '0.0.2'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'


  #  project_module :hr do
  permission :view_hr, {:hr => :index}
  permission :view_positions, {:positions => [:index,:show]}
  permission :manage_positions, {:positions => [:new,:edit,:destroy]}
  permission :view_organization_chart, {:positions => [:chart]}
  permission :view_contact_list, {:positions => [:contact_list]}
  permission :view_employees_information, {:employees => [:index]}
  permission :manage_employees_information, {:employees => [:edit]}
  #  end

  menu :top_menu, :position, { :controller => 'hr', :action => 'index'  },
    :if =>  Proc.new {
    User.current.allowed_to?({:controller => 'hr', :action => 'index'},nil, :global => true)
  },
    :caption => 'HR'





  #menu :project_menu, :position, { :controller => 'hr', :action => 'index' }, :caption => 'HR'

end
