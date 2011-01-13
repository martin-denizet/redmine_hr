class CreateUserPositions < ActiveRecord::Migration
  def self.up
    create_table :user_positions do |t|
      t.column :user_id, :integer, :uniq => true
      t.column :position_id, :integer
    end
  end

  def self.down
    drop_table :user_positions
  end
end
