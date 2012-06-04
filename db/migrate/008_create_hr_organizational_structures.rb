class CreateHrOrganizationalStructures < ActiveRecord::Migration
  def self.up
    create_table :hr_organizational_structures do |t|
      t.column :name, :string
      #t.column :manager_id, :integer
      #t.column :manager_job_title_id, :integer
      t.column :position, :integer
      t.column :organization_id, :integer
      t.column :status, :integer
      t.column :type, :string
      # awesome_nested_set
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      #t.integer :depth # this is optional.
    end
    add_index :hr_organizational_structures, [:organization_id], :name => :hr_organizational_structures_organization_id
    add_index :hr_organizational_structures, [:type], :name => :hr_organizational_structures_type
  end

  def self.down
    drop_table :hr_organizational_structures
  end
end
