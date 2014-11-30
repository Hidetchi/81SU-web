class AddEndtypeToKifu < ActiveRecord::Migration
  def self.up
    add_column :kifus, :endtype, :string
  end

  def self.down
    remove_column :kifus, :endtype
  end
end
