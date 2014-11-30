class AddColumnsToKifu < ActiveRecord::Migration
  def self.up
    add_column :kifus, :blackrate, :integer
    add_column :kifus, :whiterate, :integer
    add_column :kifus, :gametype, :string
    add_column :kifus, :server, :string
    add_column :kifus, :totaltime, :integer
    add_column :kifus, :byoyomi, :integer
  end

  def self.down
    remove_column :kifus, :byoyomi
    remove_column :kifus, :totaltime
    remove_column :kifus, :server
    remove_column :kifus, :gametype
    remove_column :kifus, :whiterate
    remove_column :kifus, :blackrate
  end
end
