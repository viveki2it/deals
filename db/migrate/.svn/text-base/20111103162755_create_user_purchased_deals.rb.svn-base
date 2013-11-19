class CreateUserPurchasedDeals < ActiveRecord::Migration
  def self.up
    create_table :user_purchased_deals do |t|
      t.integer :user_id
      t.integer :deal_id
      t.string :coupon_number
      t.string :purchased_type, :limit => 15
      t.datetime :created_at
    end
  end

  def self.down
    drop_table :user_purchased_deals
  end
end
