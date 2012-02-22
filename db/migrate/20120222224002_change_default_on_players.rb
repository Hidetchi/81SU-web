class ChangeDefaultOnPlayers < ActiveRecord::Migration
  def self.up
    change_column_default :players, :max_rate, 0
  end

  def self.down
    change_column_default :players, :max_rate, 1000
  end
end
