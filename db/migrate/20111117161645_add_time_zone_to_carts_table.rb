class AddTimeZoneToCartsTable < ActiveRecord::Migration
  def self.up
    add_column :carts, :time_zone, :string, :length => 20
  end

  def self.down
    remove_column :carts, :time_zone
  end
end
