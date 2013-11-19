class RemoveStoreId < ActiveRecord::Migration
  def self.up
    remove_column :deals, :store_id
  end

  def self.down
  end
end
