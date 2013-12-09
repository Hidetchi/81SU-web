class AddIndexToKifus < ActiveRecord::Migration
  def self.up
    add_index :kifus, :created_at
  end

  def self.down
    remove_index :kifus, :created_at
  end
end
