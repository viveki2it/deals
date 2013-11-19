class AddStoreNameToDeals < ActiveRecord::Migration
  def self.up
    add_column :deals,:store_name,:string
    add_column :deals,:store_image,:string
  end

  def self.down
    remove_column :deals,:store_name
    remove_column :deals,:store_image
  end
end
