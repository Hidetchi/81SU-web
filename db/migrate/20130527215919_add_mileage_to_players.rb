class AddMileageToPlayers < ActiveRecord::Migration
  def self.up
    add_column :players, :mileage_total, :integer, :default => 0
    add_column :players, :mileage_available, :integer, :default => 0
    add_column :players, :mileage_period, :integer, :default => 0
  end

  def self.down
    remove_column :players, :mileage_period
    remove_column :players, :mileage_available
    remove_column :players, :mileage_total
  end
end
