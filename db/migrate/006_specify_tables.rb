class SpecifyTables < ActiveRecord::Migration
  def self.up
    rename_table :user_positions, :hr_user_positions
    rename_table :user_details, :hr_user_details
  end

  def self.down
    rename_table :hr_user_positions, :user_positions
    rename_table :hr_user_details, :user_details
  end

end
