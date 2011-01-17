class AddPublicToCustomFields < ActiveRecord::Migration

  def self.up
    add_column :custom_fields, :is_public, :boolean
  end

  def self.down
    remove_column :custom_fields, :is_public
  end
end
