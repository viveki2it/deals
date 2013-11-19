class CreateCarts < ActiveRecord::Migration
  def self.up
    create_table :carts do |t|
      t.integer :user_id
      t.datetime :purchased_at
      t.datetime :created_at
    end
  end

  def self.down
    drop_table :carts
  end
end
