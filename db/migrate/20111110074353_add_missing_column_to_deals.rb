class AddMissingColumnToDeals < ActiveRecord::Migration
  def self.up
    add_column :deals,:discount_price,:float
  end

  def self.down
    remove_column :deals,:discount_price
  end
end
