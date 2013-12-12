class AddRegionIdToCountries < ActiveRecord::Migration
  def self.up
    add_column :countries, :region_id, :integer
  end

  def self.down
    remove_column :countries, :region_id
  end
end
