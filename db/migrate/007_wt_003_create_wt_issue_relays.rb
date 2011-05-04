class Wt003CreateWtIssueRelays < ActiveRecord::Migration
  def self.up
    create_table :wt_issue_relays do |t|
      t.column :issue_id, :integer
      t.column :position, :integer
      t.column :parent, :integer
    end
  end

  def self.down
    drop_table :wt_issue_relays
  end
end
