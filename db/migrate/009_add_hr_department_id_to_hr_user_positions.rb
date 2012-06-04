class AddHrDepartmentIdToHrUserPositions < ActiveRecord::Migration
  def self.up
    add_column :hr_user_positions, :hr_structure_id, :integer, :null => false
    add_column :hr_user_positions, :hr_structure_type, :string, :null => false
    add_column :hr_user_positions, :job_title_id, :integer, :null => false
    add_column :hr_user_positions, :is_manager, :boolean, :default => false, :null => false
  end

  def self.down
    remove_column :hr_user_positions, :hr_structure_id
    remove_column :hr_user_positions, :hr_structure_type
    remove_column :hr_user_positions, :job_title_id
    remove_column :hr_user_positions, :is_manager
  end
end
