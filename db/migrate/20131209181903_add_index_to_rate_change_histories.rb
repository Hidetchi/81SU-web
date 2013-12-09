class AddIndexToRateChangeHistories < ActiveRecord::Migration
  def self.up
    add_index :rate_change_histories, :player_id
  end

  def self.down
    remove_index :rate_change_histories, :player_id
  end
end
