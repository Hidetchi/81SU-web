class AddStyleIdToPlayers < ActiveRecord::Migration
  def self.up
    add_column :players, :style_id, :integer, :default => 0
  end

  def self.down
    remove_column :players, :style_id
  end
end
