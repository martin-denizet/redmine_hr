# Patches Redmine's User dynamically.  Adds a relationship
#require_dependency 'user' #Commented otherwise creates a loading
require_dependency 'issue'
require 'dispatcher'

module RedmineHr
  module Patches
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
  end
end

Dispatcher.to_prepare do
  unless User.included_modules.include?(RedmineHr::Patches::UserPatch)
    User.send(:include, RedmineHr::Patches::UserPatch)
  end
end
