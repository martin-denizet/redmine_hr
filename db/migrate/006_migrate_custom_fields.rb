class MigrateCustomFields < ActiveRecord::Migration
  def self.up
    migrate_custom_fields('UserDetailsCustomField','HrUserDetailsCustomField')
    migrate_custom_values('UserDetails','HrUserDetails')
  end

  def self.down
    migrate_custom_fields('HrUserDetailsCustomField','UserDetailsCustomField')
    migrate_custom_values('HrUserDetails','UserDetails')
  end

  def self.migrate_custom_fields(from,to)
    ActiveRecord::Base.connection.execute "UPDATE #{CustomField.table_name} SET type='"+to+"' WHERE type='"+from+"'"
  end

  def self.migrate_custom_values(from,to)
    ActiveRecord::Base.connection.execute "UPDATE #{CustomValue.table_name} SET customized_type='"+to+"' WHERE customized_type='"+from+"'"
  end

end
