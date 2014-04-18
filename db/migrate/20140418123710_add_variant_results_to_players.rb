class AddVariantResultsToPlayers < ActiveRecord::Migration
  def self.up
    add_column :players, :wins10, :integer, :default => 0
    add_column :players, :losses10, :integer, :default => 0
    add_column :players, :exp10, :integer, :default => 0
    add_column :players, :wins55, :integer, :default => 0
    add_column :players, :losses55, :integer, :default => 0
    add_column :players, :exp55, :integer, :default => 0
    add_column :players, :wins56, :integer, :default => 0
    add_column :players, :losses56, :integer, :default => 0
    add_column :players, :exp56, :integer, :default => 0
    add_column :players, :wins_ky, :integer, :default => 0
    add_column :players, :losses_ky, :integer, :default => 0
    add_column :players, :exp_ky, :integer, :default => 0
  end

  def self.down
    remove_column :players, :wins10
    remove_column :players, :losses10
    remove_column :players, :exp10
    remove_column :players, :wins55
    remove_column :players, :losses55
    remove_column :players, :exp55
    remove_column :players, :wins56
    remove_column :players, :losses56
    remove_column :players, :exp56
    remove_column :players, :wins_ky
    remove_column :players, :losses_ky
    remove_column :players, :exp_ky
  end
end
