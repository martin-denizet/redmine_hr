class RenamePositions < ActiveRecord::Migration
  def self.up
    rename_table :positions, :hr_job_titles
    remove_column :hr_job_titles, :manager_id
  end

  def self.down
    rename_table :hr_job_titles, :positions
    add_column :positions, :manager_id, :integer
  end

end
