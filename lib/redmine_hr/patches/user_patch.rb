# Patches Redmine's User dynamically.  Adds a relationship
#required, some reason it doesn't work without...
require_dependency 'issue'
#require 'user'
#require 'dispatcher'

module UserPatch

  def self.included(base) # :nodoc:
    base.class_eval do
      unloadable # Send unloadable so it will not be unloaded in development
      has_one :user_details
      has_one :user_position
      has_one :position,
        :through => :user_position
    end
  end
end

User.send(:include,UserPatch)

#Dispatcher.to_prepare do
#  unless User.included_modules.include?(RedmineHr::Patches::UserPatch)
#    User.send(:include, RedmineHr::Patches::UserPatch)
#  end
#end

