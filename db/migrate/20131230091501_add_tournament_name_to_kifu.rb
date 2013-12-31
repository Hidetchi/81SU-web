class AddTournamentNameToKifu < ActiveRecord::Migration
  def self.up
    add_column :kifus, :tournament_name, :string, :after => :contents
    add_column :kifus, :result, :integer, :after => :contents
  end

  def self.down
    remove_column :kifus, :tournament_name
    remove_column :kifus, :result
  end
end
