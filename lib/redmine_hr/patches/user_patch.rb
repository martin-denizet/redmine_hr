# Patches Redmine's User dynamically.  Adds a relationship
#required, some reason it doesn't work without...
#require_dependency 'issue'
require 'user'
#require 'dispatcher'

module HrUserPatch

  def self.included(base) # :nodoc:
    base.class_eval do
      unloadable # Send unloadable so it will not be unloaded in development
      has_one :user_details, :class_name => 'HrUserDetails', :foreign_key => 'user_id', :autosave => true, :include =>true
      accepts_nested_attributes_for :user_details #, :reject_if => :all_blank

      has_one :user_position, :class_name => 'HrUserPosition', :foreign_key => 'user_id'
      has_one :department, :class_name => 'HrDepartment', :through => :user_position, :source => :hr_structure, :source_type => 'HrDepartment'
      has_one :job_title, :class_name => 'HrJobTitle', :through => :user_position, :source => :job_title
      has_one :organization, :class_name => 'HrOrganization', :through => :user_position
    end
  end
end

#User.send(:include,HrUserPatch)

#Dispatcher.to_prepare do
#  unless User.included_modules.include?(HrUserPatch)
#    User.send(:include, HrUserPatch)
#  end
#end

User.send(:include, HrUserPatch) unless User.included_modules.include?(HrUserPatch)

# From http://strd6.com/2009/04/cant-dup-nilclass-maybe-try-unloadable/
# This plugin should be reloaded in development mode.
#if RAILS_ENV == 'development'
#  ActiveSupport::Dependencies.load_once_paths.reject!{|x| x =~ /^#{Regexp.escape(File.dirname(__FILE__))}/}
#end