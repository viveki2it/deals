class CreateUserDeals < ActiveRecord::Migration
  def self.up
    create_table :user_deals do |t|
      t.integer :user_id
      t.integer :deal_id
      t.integer :cart_id
      t.string :coupon_number

    end
  end

  def self.down
    drop_table :user_deals
  end
end
