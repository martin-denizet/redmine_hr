require 'redmine'

Redmine::Plugin.register :redmine_hr do
  name 'Redmine Hr plugin'
  author 'Author name'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'


  #  project_module :hr do
  permission :view_hr, {:hr => :index}
  permission :view_positions, {:positions => [:index,:show]}
  permission :manage_positions, {:positions => [:new,:edit,:destroy]}
  permission :view_organization_chart, {:positions => [:chart]}
  #  end

  menu :top_menu, :position, { :controller => 'hr', :action => 'index' }, :caption => 'HR'

  menu :project_menu, :position, { :controller => 'hr', :action => 'index' }, :caption => 'HR'

end
