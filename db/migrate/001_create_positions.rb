class CreatePositions < ActiveRecord::Migration
  def self.up
    create_table :positions do |t|
      t.column :title, :string
      t.column :manager_id, :integer
    end
  end

  def self.down
    drop_table :positions
  end
end
